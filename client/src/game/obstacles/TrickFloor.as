package game.obstacles
{
	import flash.display.MovieClip;
	import game.obstacles.Obstacle;

	public class TrickFloor extends Obstacle
	{
		private var state:int;
		private var contToTrick:int;
		
		public function TrickFloor(mc:MovieClip)
		{
			super(mc);
			myType = Obstacle.TRICK_FLOOR;
			state = 0;
			contToTrick = 0;
			asset.gotoAndPlay("state_" + state);
		}
		
		override public function activate():void
		{
			if (state < 2)
			{
				contToTrick++;
				if (contToTrick == 15)
				{
					contToTrick = 0;
					state++;
					asset.gotoAndPlay("state_" + state);
					if (state == 2) isKiller = true;
				}
			}
		}
		
		
		
		
	}
}