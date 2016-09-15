package tiles  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	

	public class TileSet 
	{
		private var firstgid:uint;				
		private var tilesetName:String;
		private var tileDim:Point;
		
		private var source:String;
		private var sourceDim:Point;
		
		private var tilesList:XMLList;
		private var definition:XML;
		
		public function TileSet(xml:XML){
			this.definition = xml;
			parse();
		}
		
		
		private function parse():void
		{
			firstgid = definition.attribute("firstgid");
			tilesetName = definition.attribute("name");
			tileDim = new Point(definition.attribute("tilewidth"),definition.attribute("tileheight")) ;
			
			source = definition.child("image").attribute("source");
			sourceDim = new Point(definition.child("image").attribute("width"),definition.child("image").attribute("height")); 
			
			tilesList = definition.child("tile");

			// posioblemente no quiera cargar imagenes
//			var loader:TileCodeEventLoader = new TileCodeEventLoader();
//			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, tilesLoadComplete);
//			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
//			loader.tileSet = tileSets[i];
//			loader.load(new URLRequest(path + tileSets[i].source));
			
			logger.info("new Tileset: ");
			logger.info(firstgid, tilesetName, tileDim, source, sourceDim);
			
		}

		
//		public function getType(gid:int):String
//		{
//			return tilesData[gid];
//		}
		
		

		public function getTileBitmap(gid:int):Bitmap{
			
			var bmd:BitmapData = new BitmapData(dimension.x, dimension.y, true, 0x0);
			var sourceY:int = Math.ceil(gid/dimension.x)-1;
			var sourceX:int = gid - (dimension.y * sourceY) - 1;
			var bitmapData:BitmapData;
			
			bmd.copyPixels(
				bitmapData, 
				new Rectangle(sourceX * dimension.x, sourceY * dimension.x, dimension.x, dimension.y), 
				new Point(0, 0), 
				null, null, true);
			
			var bmp:Bitmap = new Bitmap(bmd);
			return bmp;
		}
		
		public function get dimension():Point
		{
			return new Point(definition.tilewidth, definition.tileheight);
		}
		
		public function get name():String
		{
			return tilesetName;
		}
		
		
		
		public function tileName(gid:uint):String
		{
			var id:int = gid + firstgid;

			for each(var tile:XML in tilesList.children()){
				if(tile.attribute(id) == id){
					trace(tile);
				}
			}

			return tilesList.child(id).attribute("name");
		}
		
	}

}