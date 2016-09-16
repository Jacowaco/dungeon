package avtr
{
	import com.qb9.flashlib.geom.Vector2D;

	public class Body
	{
		public static var VERTICAL:int = 1;
		public static var HORIZONTAL:int = 2;
		
		protected var pos:Vector2D;		
		protected var grav:Vector2D;
		protected var vel:Vector2D;
//		protected var mass:Number;
		
		private var addGravity:Boolean = true;
		
		public function Body()
		{
			grav = new Vector2D(0, 1);
			vel = new Vector2D(0,0);
			pos = new Vector2D(15,15);
		}
		
		public function update():void
		{
			this.vel = this.vel.add(this.grav); 
			this.pos = this.pos.add(this.velocity);
		}
		
		public function get x():Number 
		{
			return pos.x;
		}
		
		public function get y():Number 
		{
			return pos.y;
		}
		
		public function set x(x:Number):void 
		{
			pos = new Vector2D(x, pos.y);
		}
		
		public function set y(y:Number):void 
		{
			pos = new Vector2D(pos.x, y);
		}

		public function get velocity():Vector2D
		{
			return vel;
		}

		public function set velocity(value:Vector2D):void
		{
			vel = value;
		}

		public function get gravity():Vector2D
		{
			return grav;
		}

		public function set gravity(value:Vector2D):void
		{
			grav = value;
		}

		
	}
}