package avtr
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import game.obstacles.Obstacle;
	
	
	public class IdleState extends AvatarState
	{
		public function IdleState(context:Avatar){
			this.context = context;
		}
	
		override public function enter():void
		{
//			logger.info("enter idle state");
			context.vel = new Vector2D();
		}
		
		override public function exit():void{
//			logger.info("exit idle state");
		}
		
		
		override public function checkState():void
		{
			if(context.left || context.right) context.setWalkState();
			if (context.jump) context.setJumpState();
		}
		
		override public function update():void 
		{
			if (context.touchingFloor) context.vel = new Vector2D();
			else context.addGravity();
			context.addVelocity();
//			context.move();
		}
	}
}