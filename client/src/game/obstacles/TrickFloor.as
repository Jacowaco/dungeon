package game.obstacles
{
	import com.qb9.flashlib.tasks.Timeout;
	
	import flash.display.MovieClip;
	
	import game.obstacles.Obstacle;

	public class TrickFloor extends Obstacle
	{
		private var activated:Boolean;
		private var timeout:Timeout;
		private var delay:int;
		public function TrickFloor(mc:MovieClip)
		{
			super(mc);
			myType = Obstacle.TRICK_FLOOR;
			goIdle();
			activated = false;
		}
		
		override public function config(settings:Object):void
		{
			//logger.info("configuring trick");
			//trace(settings);
			//trace(settings.obstacles.trickTime);
			delay = settings.tricks * 1000;
			//delay = settings.obstacles.trickTime * 1000;
			//delay = 2 * 1000;
		}
		
		override public function activate():void
		{
			if (!activated)
			{
				activated = true;
				goWarning();
				timeout = new Timeout(goKill, delay );
				Game.taskRunner().add(timeout);
			}
		}		
	}
}