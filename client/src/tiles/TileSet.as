package tiles  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	

	public class TileSet 
	{

		
		/*
		{
		"firstgid":1,
		"image":"tileset.png",
		"imageheight":400,
		"imagewidth":400,
		"margin":0,
		"name":"tileset",
		"properties":
		{
		
		},
		"spacing":0,
		"tileheight":40,
		"tilewidth":40,
		"tileproperties":
		{
		"0":
		{
		"name":"floor"
		},
		"1":
		{
		"name":"obstacle"
		}
		}
		
		}
		*/
		
		private var firstgid:uint;				
		private var tilesetName:String;
		private var tileDimension:Point;
		
		private var image:String;
		private var imageDimension:Point;

		private var tileProperties:Object;

		
		
		public function TileSet(ts:Object){
		
			
			firstgid = ts.firstgid;
			tilesetName = ts.name;
			
			tileDimension = new Point(ts.tilewidth,ts.tileheight) ;
			
			image = ts.image;
			imageDimension = new Point(ts.imagewidth,ts.imageheight); 
			
			tileProperties = ts.tileproperties;
			

			// posioblemente no quiera cargar imagenes
//			var loader:TileCodeEventLoader = new TileCodeEventLoader();
//			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, tilesLoadComplete);
//			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
//			loader.tileSet = tileSets[i];
//			loader.load(new URLRequest(path + tileSets[i].source));
			
			logger.info("new Tileset: ");
			logger.info(firstgid, tilesetName, tileDimension, image, imageDimension);
			
		}

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
			return tileDimension;
		}
		
		public function get name():String
		{
			return tilesetName;
		}
		
		
		
		public function tileName(gid:uint):String
		{
			var id:int = gid - firstgid;
			return gid == 0 ? "empty" : tileProperties[id].name;
				
		}
		
	}

}