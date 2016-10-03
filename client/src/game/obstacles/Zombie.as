package game.obstacles
{
	import com.qb9.flashlib.tasks.Func;
	import com.qb9.flashlib.tasks.Loop;
	import com.qb9.flashlib.tasks.Sequence;
	import com.qb9.flashlib.tasks.Timeout;
	
	import flash.display.MovieClip;
	
	import game.obstacles.Obstacle;

	public class Zombie extends Obstacle
	{
//		private var state:int;
		
//		private var contToTrick:int;
		
		private var timer:Loop;
		private var sequence:Sequence;
		private var idle:Timeout;
		private var warning:Timeout;
		private var kill:Timeout;
		
		public function Zombie(mc:MovieClip)
		{
			super(mc);
			myType = Obstacle.ZOMBIE;
			asset.gotoAndPlay(IDLE);
			
		}
		
		override public function config(settings:Object):void
		{
			this.settings = settings;		
			idle = new Timeout(goIdle, settings.idleTime);
			warning = new Timeout(goWarning, settings.warningTime);
			kill = new Timeout(goKill, settings.killerTime);
			
			sequence = new Sequence(idle, warning, kill);
			timer = new Loop(sequence);
			
			Game.taskRunner().add(timer);
						
		}
		
		
		override public function activate():void
		{
//			if (state < 2)
//			{
//				contToTrick++;
//				if (contToTrick == 15)
//				{
//					contToTrick = 0;
//					state++;
//					asset.gotoAndPlay("state_" + state);
//					if (state == 2) isKiller = true;
//				}
//			}
		}
		
		
		
		
	}
}