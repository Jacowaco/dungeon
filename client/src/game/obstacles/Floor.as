package game.obstacles
{
	import flash.display.MovieClip;

	public class Floor extends Obstacle
	{ 
		public function Floor(mc:MovieClip)
		{
			super(mc);
			myType = Obstacle.FLOOR;
		}
		
		override public function activate():void
		{
			// aca no hago nada...
			// el piso nunca me mata
		}
		override public function dispose():void{
			
		}
	}
}