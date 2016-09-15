package tiles
{
	import com.adobe.serialization.json.JSON;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.Event;
	import flash.geom.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import org.as3commons.zip.Zip;
	import org.as3commons.zip.ZipFile;
	
	import utils.Utils;

	/*
	el TileMap tiene un objecto completo con capas	
	cada capa es un TileLayer (una pantalla) 
	también guarda un Tileset que es la estructura que tiene la relación entre los gid y el asset (además de las constantes que definen a los tiles)
	*/
	public class TileMap  extends EventDispatcher
	{
		private var debug:Boolean = true;
		
		public static var MAP_READY:String = "mapReady";
		
		private var jsonfile:URLLoader; 	// for reading the tmx file
//		private var xml:XML; 			 	// for storing the tmx data as xml		
		private var data:Object;
		private var isZip:Boolean;			// por si quiero cargar el mapa comprimido
		private var mapfile:String;			// el xml sacado del tiled
		private var path:String;			// donde esta...
		
		private var mapWidth:uint;
		private var mapHeight:uint;
		private var tileWidth:uint;
		private var tileHeight:uint;
		private var layersCount:uint;
		
		private var tileSets:Array = [];
		private var totalTileSets:uint = 0;
		private var tileSetsLoaded:uint = 0;
		private var currentTileset:uint = 0;

		private var layers:Object = {}; 
		
		public function TileMap(path:String, mapfile:String):void 
		{
			this.path = path;
			this.mapfile = mapfile;			
			isZip = mapfile.split('.')[mapfile.split('.').length - 1] == "zip" ? true : false;			
			init(isZip);
		}
		
		private function init(isZip:Boolean):void 
		{
				if(debug) logger.info("TilemapLoader init: ");
				jsonfile = new URLLoader();
				if(isZip) jsonfile.dataFormat = URLLoaderDataFormat.BINARY;
				jsonfile.addEventListener(Event.COMPLETE, loadComplete);
				jsonfile.load(new URLRequest(path+mapfile));		
		}
		
		private function loadComplete(e:Event):void {
			
			if(debug) logger.info("TilemapLoader json load complete: ");		
		
			parseFile(e);
			loadTilesets();
			loadLayers();
			// cuando cargue todo salgo...
			dispatchEvent(new Event(MAP_READY));
		}
		
		private function parseFile(e:Event):void
		{
			if(isZip){
				var ba:ByteArray = ByteArray(e.target.data);
				var zip:Zip = new Zip();
				zip.loadBytes(ba);
				for(var i:uint = 0; i < zip.getFileCount(); i++) {				
					var zipFile:ZipFile = zip.getFileAt(i);
					var bytes:ByteArray = zipFile.content;
					data = JSON.decode(zipFile.content.readUTFBytes(zipFile.content.length)); 
				}		
			}else{
				data = JSON.decode(e.target.data);
			}
			
			mapWidth = data["width"];
			mapHeight = data["height"];
			tileWidth = data["tilewidth"];
			tileHeight = data["tileheight"];	
		}
		
		private function progressHandler(event:ProgressEvent):void {
			if(debug) logger.info("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
		}
		
		private function loadTilesets():void
		{
			logger.info("loading Tilesets");
			for each(var ts:Object in data.tilesets){
				tileSets.push(new TileSet(ts));
			}			
		}

		/*
		{
		"data":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		"height":12,
		"name":"level_1",
		"opacity":1,
		"type":"tilelayer",
		"visible":true,
		"width":20,
		"x":0,
		"y":0
		}
		*/
		private function loadLayers():void {	
			logger.info("loading layers: ");
			
			for each(var layer:Object in data.layers){
				var name:String = layer.name;
				var w:int = layer.width;
				var h:int = layer.height;
				
				var map:Array = new Array(); 			// el mapa de una capa (bidimensional)				
				var tilesList:Array = new Array();		// los tiles para esa capa (unidimensional)
				var currentTile:uint = 0;
				// assign the gid to each location in the layer
//				for each (var tileid:int in layer.data) {					
//					var t:Tile = new Tile(tileSets[currentTileset], tileid);   // uno solo tileset por ahora... le paso el tileset y el id para que lo cree
//					tilesList[currentTile] = t; 
//					currentTile++;
//				}		
				
				// store the gid into a 2d array (para esa capa)
				for (var tileX:int = 0; tileX < w; tileX++) {
					map[tileX] = new Array();
					for (var tileY:int = 0; tileY < h; tileY++) { 
						var t:Tile = new Tile(tileSets[currentTileset], layer.data[(tileX+(tileY*w))]);   // uno solo tileset por ahora... le paso el tileset y el id para que lo cree						
						map[tileX][tileY] = t;
					}
				}
				
				if(debug) logger.info("saving layer: " + name);
				
				
				// me guardo ese mapa
				var tl:TileLayer = new TileLayer();
				tl.setName(name);
				tl.setMap(map);
				tl.setDimensions(w, h);
				layers[name] = tl;
				
			}
			
 
				
				
			
	
			
			
			Utils.getProperties(layers);
		}
		
		public function getLayers():Object
		{
			return layers;
		}

		
		// ---------------------------------
		public function getLayer(layer:String):TileLayer
		{
			return this.layers[layer] as TileLayer; 
		}
		
	


		
		public function tileDimension():Point
		{
//			return (tileSets[0] as TileSet).tileDimension();
			return new Point();
		}
		
		public function get numLayers():uint
		{
			return layersCount;
		}
		
//		override public function toString():String
//		{
//			return Utils.getProperties(layers).toString();
//		}
	}
	
}

