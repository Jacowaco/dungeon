package game.obstacles
{
	import flash.display.MovieClip;

	public class Pit extends Obstacle
	{ 
		public function Pit(mc:MovieClip)
		{
			super(mc);
			myType = Obstacle.PIT;
			isKiller = true;
		}
		
		override public function activate():void
		{
			
		}
		override public function dispose():void{
			
		}
	}
}