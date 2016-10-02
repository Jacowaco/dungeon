package game.obstacles
{
	import flash.display.MovieClip;

	public class Brick extends Obstacle
	{ 
		public function Brick(mc:MovieClip)
		{
			super(mc);
			myType = Obstacle.BRICK;
		}
		
		override public function activate():void
		{
			// aca no hago nada...
			// el piso nunca me mata
		}
		
		
		
		
	}
}