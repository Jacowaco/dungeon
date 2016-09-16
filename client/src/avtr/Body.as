package avtr
{
	import com.qb9.flashlib.geom.Vector2D;

	public class Body
	{
		public static var DOWN:int = -1;
		
		protected var gravity:Vector2D;
		protected var speed:Vector2D;
		protected var vel:Vector2D;
		protected var position:Vector2D;
		protected var mass:Number;
		
		private var addGravity:Boolean = true;
		
		public function Body()
		{
			gravity = new Vector2D(0, 1);
			velocity = new Vector2D(0,0);
			position = new Vector2D(15,15);
			speed = new Vector2D();
		}
		
		public function update():void
		{
			this.velocity = this.vel.add(this.speed);
			if(addGravity) this.vel = this.vel.add(this.gravity);
			this.position = this.position.add(this.velocity);
			
			addGravity = true;
		}
		
		public function get x():Number 
		{
			return position.x;
		}
		
		public function get y():Number 
		{
			return position.y;
		}
		
		public function set x(x:Number):void 
		{
			position = new Vector2D(x, position.y);
		}
		
		public function set y(y:Number):void 
		{
			position = new Vector2D(position.x, y);
		}

		public function get velocity():Vector2D
		{
			return vel;
		}

		public function set velocity(value:Vector2D):void
		{
			vel = value;
		}
		
		public function collide(direction:int):void{
			if(direction == DOWN) {				
				vel = new Vector2D(vel.x, 0);
			}
		}
		
		
	}
}