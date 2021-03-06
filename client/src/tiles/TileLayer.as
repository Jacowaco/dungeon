package tiles
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class TileLayer
	{
		
		private var mapWidth:int; 
		private var mapHeight:int; 
		private var rows:int;
		private var cols:int;
		public var name:String;
		private var map:Array;
		public var props:Object;
		
		public function TileLayer()
		{
					
		}
				
		public function setDimensions(mw:int, mh:int):void
		{
			this.mapHeight = mh;
			this.mapWidth = mw;
			this.cols = mapWidth ;
			this.rows = mapHeight ;
		}
		
		public function getTile(x:int, y:int):Tile
		{
			return map[x][y] as Tile;
		}

		
		public function getRowsCount():int
		{
			return rows;
		}
		
		public function getColsCount():int
		{
			return cols;
		}
		
		
		public function setMap(map:Array):void
		{
			this.map = map;
		}

		public function getTilesCount(type:String):int
		{
			var qty:int = 0;
			for(var x:int = 0; x < cols; x++){
				for(var y :int = 0; y < rows; y++)
				{
					var t:Tile = getTile(x,y);
					if (t.name == type) qty++;
				}
			}
			return qty;
		}
		
		public function findTile(type:String):Tile
		{
			// funciona siempre que haya 1 y solo uno de ese tipo
			for(var x:int = 0; x < cols; x++){
				for(var y :int = 0; y < rows; y++)
				{
					var t:Tile = getTile(x,y);
					if (t.name == type) return t;
				}
			}
			return null;
		}
		
		public function setName(name:String):void
		{
			this.name = name;
		}
		
		public function setProps(props:Object):void
		{
			this.props = props;
		}
	}
}