package avtr
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import game.obstacles.Obstacle;
	

	public class DeadState extends AvatarState
	{
		public function DeadState(context:Avatar)
		{
			this.context = context;
		}
		
		override public function enter():void
		{
			var deadJump:Vector2D = new Vector2D(0, -context.jumpForce);		
			context.vel = deadJump;
		}
		
		override public function exit():void
		{
//			logger.info("exit walk state");			
		}
		
		override public function checkState():void
		{
			
		}
		
		override public function update():void 
		{
			//context.vel = context.deadVel;
			context.addGravity();
//			context.move();
		}

	}
}