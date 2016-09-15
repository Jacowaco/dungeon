package tiles
{
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
		
		private var xmlLoader:URLLoader; 	// for reading the tmx file
		private var xml:XML; 			 	// for storing the tmx data as xml		
		private var isZip:Boolean;			// por si quiero cargar el mapa comprimido
		private var mapfile:String;			// el xml sacado del tiled
		private var path:String;			// donde esta...
		
		private var mapWidth:uint;
		private var mapHeight:uint;
		private var tileWidth:uint;
		private var tileHeight:uint;
		private var layersCount:uint;
		
		// un array de objetos Tilesets
		// cada tileset es una imagen con tiles usadas en el mapa
		// con la info de propiedades de cada tile
		private var tileSets:Array = [];
		private var totalTileSets:uint = 0;
		private var tileSetsLoaded:uint = 0;
		private var currentTileset:uint = 0;
		
		// un objeto que guarda un TileMap para cada capa
		// cada tileMap guarda el tileset que usa y un array[][] con sus tiles
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
				xmlLoader = new URLLoader();
				if(isZip) xmlLoader.dataFormat = URLLoaderDataFormat.BINARY;
				xmlLoader.addEventListener(Event.COMPLETE, xmlLoadComplete);
				xmlLoader.load(new URLRequest(path+mapfile));		
		}
		
		private function xmlLoadComplete(e:Event):void {
			
			if(debug) logger.info("TilemapLoader xml load complete: ");		
		
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
					xml = new XML(zipFile.content.readUTFBytes(zipFile.content.length));				
				}		
			}else{
				xml = new XML(e.target.data);
			}
			
			
			mapWidth = xml.attribute("width");
			mapHeight = xml.attribute("height");
			tileWidth = xml.attribute("tilewidth");
			tileHeight = xml.attribute("tileheight");	
			
		}
		
		private function progressHandler(event:ProgressEvent):void {
			if(debug) logger.info("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
		}
		
		
		private function loadTilesets():void
		{
			logger.info("loading Tilesets");
			var tsCount:uint = 0;
			
			for each (var tileset:XML in xml.tileset) {
								
				var ts:TileSet = new TileSet(tileset);
				tileSets[tsCount] = ts;
				tsCount++;
			}
			
			totalTileSets = tsCount;
			
		}

		private function loadLayers():void {	
			logger.info("loading layers: ");
			// load each layer
			for each (var layer:XML in xml.layer) {				
				var name:String = layer.attribute("name");
				var w:int = layer.attribute("width");
				var h:int = layer.attribute("height");
				
				var map:Array = new Array(); 			// el mapa de una capa (bidimensional)				
				var tilesList:Array = new Array();		// los tiles para esa capa (unidimensional)
				var currentTile:uint = 0;
				// assign the gid to each location in the layer
				for each (var tile:XML in layer.data.tile) {
//					// el gid es un numero asociado con un tile especifico entre todos los tilesets
//					// ver "understanding gid"  en http://gamedevelopment.tutsplus.com/tutorials/parsing-and-rendering-tiled-tmx-format-maps-in-your-own-game-engine--gamedev-3104 
					var gid:Number = tile.attribute("gid");					
//					// lo que quiero es que en la unidad Tile tener toda la data disponible. el asset, la posicion y el tipo
					var t:Tile = new Tile(tileSets[currentTileset], gid);   // uno solo tileset por ahora... le paso el tileset y el id para que lo cree
					tilesList[currentTile] = t; 
					currentTile++;
				}		
				// store the gid into a 2d array (para esa capa)
				for (var tileX:int = 0; tileX < w; tileX++) {
					map[tileX] = new Array();
					for (var tileY:int = 0; tileY < h; tileY++) {
						var t:Tile = tilesList[(tileX+(tileY*w))];
						t.setLocation(tileX, tileY);						
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
			
				layersCount++;
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
		
//		private function getTilesetForGID(tileGid:uint):TileSet
//		{
//			
//			/*
//			var currentTileset:TileSet;
//			for each( var ts:TileSet in tileSets) {             
//			if (tileGid >= ts.firstgid-1 && tileGid <  ts.lastgid)             
//			{
//			currentTileset = ts;
//			break;
//			}
//			}
//			*/
//			
//			// CHAMUYYYYYYOOOOOO
//			return tileSets[0];
//			//			return currentTileset;
//		}
		
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

