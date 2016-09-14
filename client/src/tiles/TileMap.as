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
		private var tileSets:Array = new Array();
		private var totalTileSets:uint = 0;
		private var tileSetsLoaded:uint = 0;				
		
		// un objeto que guarda un TileMap para cada capa
		// cada tileMap guarda el tileset que usa y un array[][] con sus tiles
		private var layers:Object = new Object(); 
		
		private var eventLoaders:Array= new Array();	// carga los tiles (pngs)
		
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
			loadTilesets();			
		}
		
		
		private function progressHandler(event:ProgressEvent):void {
			if(debug) logger.info("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
		}
		
		
		private function loadTilesets():void
		{
			logger.info("loading Tilesets");
			var xmlCounter:uint = 0;
			
			for each (var tileset:XML in xml.tileset) {
				
//				var imageWidth:uint = xml.tileset.image.attribute("width")[xmlCounter];
//				var imageHeight:uint = xml.tileset.image.attribute("height")[xmlCounter];
//				var firstGid:uint = xml.tileset.attribute("firstgid")[xmlCounter];
//				var tilesetName:String = xml.tileset.attribute("name")[xmlCounter];
//				var tilesetTileWidth:uint = xml.tileset.attribute("tilewidth")[xmlCounter];
//				var tilesetTileHeight:uint = xml.tileset.attribute("tileheight")[xmlCounter];
//				var tilesetImagePath:String = xml.tileset.image.attribute("source")[xmlCounter];
//				
//				var ts:TileSet = new TileSet(firstGid, tilesetName, tilesetTileWidth, tilesetTileHeight, tilesetImagePath, imageWidth, imageHeight);
				
				var ts:TileSet = new TileSet(tileset);
//				for each (var tile:XML in tileset.tile)
//				{
//					var id:String = (int(tile.attribute("id")) + 1).toString();
//					var props:XMLList = tile.child("properties");
//					ts.tilesData[id] = props.property.attribute("value").toString();
//					if(debug) logger.info("tileset data");
//					if(debug) logger.info(props.property.attribute("name"));
//					if(debug) logger.info(props.property.attribute("value"));						
//				}				
//				
				tileSets.push(ts);
				xmlCounter++;
			}
			
			totalTileSets = xmlCounter;
			
			// load images for tileset
//			for (var i:int = 0; i < totalTileSets; i++) {
//				if(debug) logger.info("load tilset at " + tileSets[i].source);
//				var loader:TileCodeEventLoader = new TileCodeEventLoader();
//				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, tilesLoadComplete);
//				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
//				loader.tileSet = tileSets[i];
//				loader.load(new URLRequest(path + tileSets[i].source));
//				eventLoaders.push(loader);
//			}			
		}
		
		
		
		
		private function tilesLoadComplete (e:Event):void {
//			var ts:TileSet = e.target.loader.tileSet;
//			ts.bitmapData = Bitmap(e.target.content).bitmapData;
//			tileSetsLoaded++;
//			
//			if (tileSetsLoaded == totalTileSets)
//			{
//			
//			}
//			createMapLayers();
		}
		
		
		/*
		private function createMapLayers():void {	
			trace("tileset");
			trace(xml.tileset);
			
			
			
			
			// load each layer
			for each (var layer:XML in xml.layer) {				
				
				var tileSet:TileSet = new TileSet(xml.tileset);	
					
				var map:Array = new Array(); 			// el mapa de una capa (bidimensional)				
				var tilesList:Array = new Array();		// los tiles para esa capa (unidimensional)
				var currentTile:uint = 0;
				var w:int = layer.attribute("width")[0];
				var h:int = layer.attribute("height")[0];
				
				
				
				
				// assign the gid to each location in the layer
				for each (var tile:XML in layer.data.tile) {
					// el gid es un numero asociado con un tile especifico entre todos los tilesets
					// ver "understanding gid"  en http://gamedevelopment.tutsplus.com/tutorials/parsing-and-rendering-tiled-tmx-format-maps-in-your-own-game-engine--gamedev-3104 
					var gid:Number = tile.attribute("gid");
					
//					
					
					var t:Tile = new Tile(tileSet.getType(gid), gid);
					t.dimension = new Point(tileSet.tileWidth, tileSet.tileHeight);
					
					tilesList[currentTile] =t; 
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
				var layerName:String = layer.attribute("name")[0];
				if(debug) logger.info("saving layer :" + layerName); 
				// me guardo una propiedad con ese mapa
				var tl:TileLayer = new TileLayer();
				tl.setName(layerName);
				tl.setMap(map);
				tl.setTileSet(tileSet);
				tl.setDimensions(w, h);
				layers[layerName] = tl;
			}
			// cuando cargue todo salgo...
			dispatchEvent(new Event(MAP_READY));
		}
		
		*/
		
		// ---------------------------------
		public function getTileLayer(layer:String):TileLayer
		{
			if(layers.hasOwnProperty(layer)) {				
				return layers[layer];
			}
			
			return null;
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
	}
	
}

