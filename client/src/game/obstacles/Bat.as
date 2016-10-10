package game.obstacles
{
	import com.qb9.flashlib.tasks.Func;
	import com.qb9.flashlib.tasks.Loop;
	import com.qb9.flashlib.tasks.Sequence;
	import com.qb9.flashlib.tasks.Timeout;
	import flash.events.Event;
	
	import flash.display.MovieClip;
	
	import game.obstacles.Obstacle;

	public class Bat extends Obstacle
	{	
		private var timer:Loop;
		private var sequence:Sequence;
		private var idle:Timeout;
		private var warning:Timeout;
		private var kill:Timeout;
		
		public function Bat(mc:MovieClip)
		{
			super(mc);
			myType = Obstacle.BAT;
			//asset.gotoAndPlay(IDLE);
			isKiller = true;
		}
		
		override public function config(settings:Object):void
		{
			logger.info("configuring bat");
			this.settings = settings;	
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			//idle = new Timeout(goIdle, settings.zombies * 1000);
			//warning = new Timeout(goWarning, settings.zombies * 1000);
			//kill = new Timeout(goKill, settings.zombies * 1000);			
			//sequence = new Sequence(idle, warning, kill);
			//timer = new Loop(sequence);			
			//Game.taskRunner().add(timer);						
		}
		
		private function onEnterFrame(e:Event):void
		{
			x--;
			if (x < 0)
			{
				//resetear
			}
		}
		
 		override public function activate():void
		{
			// nada que hacer aca...
		}
		
	}
}