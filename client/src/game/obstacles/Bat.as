package game.obstacles
{
	import com.qb9.flashlib.easing.Tween;
	import com.qb9.flashlib.tasks.Func;
	import com.qb9.flashlib.tasks.Loop;
	import com.qb9.flashlib.tasks.Sequence;
	import com.qb9.flashlib.tasks.Timeout;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	import game.obstacles.Obstacle;

	public class Bat extends Obstacle
	{	
		private var loop:Loop;
		private var sequence:Sequence;
		private var goLeft:Tween;
		private var goRight:Tween;
//		private var reset:Func;
//		private var kill:Timeout;
		
		private var location:Point;
		private var time:int = 3000;
		
		public function Bat(mc:MovieClip)
		{
			super(mc);
			myType = Obstacle.BAT;
			//asset.gotoAndPlay(IDLE);
			isKiller = true;
			location = new Point(this.x, this.y);
		}
		
		override public function config(settings:Object):void
		{
			logger.info("configuring bat");
			this.settings = settings;	
			
//			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
//			reset = new Func(function():void{ time = Math.floor(1000 + Math.random() * 3000); trace(time)});
			goLeft = new Tween(this, time, { "x": location.x - 400 });
			goRight = new Tween(this, time, { "x": location.x + 400 });
			//idle = new Timeout(goIdle, settings.zombies * 1000);
			//warning = new Timeout(goWarning, settings.zombies * 1000);
			//kill = new Timeout(goKill, settings.zombies * 1000);			
			sequence = new Sequence(goLeft, goRight);
			loop = new Loop(sequence);			
			Game.taskRunner().add(loop);						
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