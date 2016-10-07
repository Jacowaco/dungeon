package avtr
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import game.obstacles.Obstacle;
	

	public class HookState extends AvatarState
	{
		public function HookState(context:Avatar)
		{
			this.context = context;
		}
		
		override public function enter():void
		{
//			logger.info("enter walk state");	
		}
		
		override public function exit():void
		{
//			logger.info("exit walk state");			
		}
		
		override public function checkState():void
		{
			//if(!(context.left || context.right)) context.setIdleState();
			if (context.jump)
			{
				//context.currentHook = null;
				context.setJumpState();
			}
		}
		
		override public function update():void 
		{
			//if (context.touchingFloor) context.vel = new Vector2D();
			//else context.addGravity();
			//context.addController();
			//context.move();
			
			context.updateToHook();
		}

	}
}