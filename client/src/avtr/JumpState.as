package avtr
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import game.Thing;
	
	public class JumpState extends FallState
	{
		
		private var secondJumpCompleted:Boolean = false;
		private var canJumpAgain:Boolean = true;
		
		public function JumpState(context:Avatar){
			super(context);
		}
		
		override public function enter():void{
			logger.info("enter jump state");			
			jump();
			context.contact = null;
			canJumpAgain = false;
			secondJumpCompleted = false;
		}
		
		override public function exit():void{
//			logger.info("exit jump state");
		}
		
//		override public function checkCollisions(platforms:Array):void
//		{
//			if(!context.isFalling()) return;	// estoy subiendo no quiero saber nada
//			return super.checkCollisions(platforms);
//		}
//		
//		override public function handleCollition(p:Thing):void
//		{
//			var gato:Rectangle = context.getTarget();
//			var plat:Rectangle = p.getTarget();
//			if(Math.abs(plat.top - gato.bottom) < 20 ){									
//				context.vel = new Vector2D(context.vel.x, 0);
//				context.moveBy(0, plat.top - gato.bottom);  // fuerzo a que el gato se pare en la plataforma
//				p.triggerAction();
//				if(!p.touched) {
//					p.touched = true;
//				}
//				context.contact = p;
//				context.idle();																	
//			}		
//			
//		}
		
		
		private function jump():void
		{
			var jump:Vector2D = new Vector2D(context.vel.x, -context.jumpForce);		
			context.vel = context.vel.add(jump);		
		}
		
//		override public function onKeyDown(ke:KeyboardEvent):void{
//			if(!canJumpAgain) return;
//			
//			if(ke.keyCode == Keyboard.SPACE){
//				if(secondJumpCompleted) return;
//				jump(0.5);
//				secondJumpCompleted = true;
//			}
//		}		
//		override public function onKeyUp(ke:KeyboardEvent):void{
//			canJumpAgain = ke.keyCode == Keyboard.SPACE ? true : false;
//		}
		
	}
}