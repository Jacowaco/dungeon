package game.obstacles
{
	import com.qb9.flashlib.tasks.Timeout;
	
	import flash.display.MovieClip;
	
	import game.obstacles.Obstacle;

	public class TrickFloor extends Obstacle
	{
		private var timeout:Timeout;
		private var delay:int;
		public function TrickFloor(mc:MovieClip)
		{
			super(mc);
			myType = Obstacle.TRICK_FLOOR;
			goIdle();
		}
		
		override public function config(settings:Object):void
		{
			logger.info("configuring trick");
			delay = settings.tricks * 1000;
		}
		
		override public function activate():void
		{
			goWarning();
			timeout = new Timeout(goKill, delay );
			Game.taskRunner().add(timeout);
		}		
	}
}