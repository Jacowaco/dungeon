package tiles
{
	import flash.geom.Point;

	public class Tile
	{
		private var nameDef:String;
		private var id:uint;
		private var loc:Point;
		private var dim:Point;		
		private var tileSet:TileSet;   // me guardo la refe al tileset que pertenezco
		
		public function Tile(ts:TileSet, gid:uint)
		{
			this.tileSet = ts;
			this.id = gid;
			
			create();
		}
				
		private function create():void
		{
			this.nameDef = tileSet.tileName(gid);
			this.dim = tileSet.dimension;

		}
		
		public function toString():String
		{
			return ("gid: " + id + " type: " + nameDef + " location: " + loc);
		}
			
		public function get dimension():Point
		{
			return dim ? dim : new Point();
		}
		
		public function get gid():uint
		{
			return id;
		}
		
		public function get name():String
		{
			return this.nameDef;
		}
		
	}
}