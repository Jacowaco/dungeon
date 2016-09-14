package tiles
{
	import flash.geom.Point;

	public class Tile
	{
		private var type:String;
		private var id:uint;
		private var loc:Point;
		private var dim:Point;		
		
		public function Tile(type:String, gid:uint)
		{
			this.type = type;
			this.id = gid;
		}
		

		
		public function toString():String
		{
			return ("gid: " + id + " type: " + type + " location: " + loc);
		}
		
		public function setLocation(x:int, y:int):void		
		{
			// los tiles son origin en top/left
			this.loc = new Point(x, y);
		}
		
		public function obstacle():Boolean
		{
			return (type == "OBSTACLE");
		}
		
		public function get dimension():Point
		{
			return dim ? dim : new Point();
		}
		
		public function set dimension(dim:Point):void
		{
			this.dim = dim;
		}
		
		public function set gid(id:uint):void
		{
			this.id = id;	
		}
		
		public function get gid():uint
		{
			return id;
		}
		
		public function get name():String
		{
			return this.type;
		}
		
		public function set name(name:String):void 
		{
			this.type = name;	
		}
	}
}