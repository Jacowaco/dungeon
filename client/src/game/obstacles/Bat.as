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
			//logger.info("configuring bat");
			this.settings = settings;	
			
			goLeft = new Tween(this, time, { "x": location.x - 200 });
			goRight = new Tween(this, time, { "x": location.x + 200 } );
			
			if (Math.random() < 0.5) sequence = new Sequence(goLeft, goRight);
			else sequence = new Sequence(goRight, goLeft);
			
			loop = new Loop(sequence);			
			Game.taskRunner().add(loop);						
		}
		
 		override public function activate():void
		{
			// nada que hacer aca...
		}
		
		override public function dispose():void{
			goRight.dispose();
			goLeft.dispose();
			sequence.dispose();
			loop.dispose();
		}
		
	}
}