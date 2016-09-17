package avtr
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import game.Thing;
	

	public class WalkState extends AvatarState
	{
		private var offset:Number = 0;
		
		public function WalkState(context:Avatar)
		{
			this.context = context;
		}
		
		override public function enter():void
		{
//			logger.info("enter walk state");
			offset = context.contact.pos.x - context.position.x;			
		}
		
		override public function exit():void
		{
//			logger.info("exit walk state");			
		}
		
		override public function update(keys:Object):void
		{	
			var direction:Vector2D = resolveDirection(keys);
			if(context.contact) {				
				offset -= direction.x * context.speed;
			}			
			context.moveTo(context.contact.pos.x - offset, context.position.y);
		}
		
		override public function onKeyDown(ke:KeyboardEvent):void
		{			
			if(ke.keyCode == Keyboard.SPACE){
				context.jump();
			}
		}
		
		override public function onKeyUp(ke:KeyboardEvent):void
		{
			context.idle();
		}

		// en este caso tengo que reeimplementar este metodo
		// porque el padre lo que hace es filtrar las que puedo estar parado
		// y justamente necesito darme cuenta que no estoy parado sobre una..
		override public function checkCollisions(platforms:Array):void
		{
			for each(var p:Thing in platforms){	
				if(p == context.contact) handleCollition(p);				
			}	
		}
	
		override public function handleCollition(p:Thing):void
		{				
			var gato:Rectangle = context.getTarget();   			
			var plat:Rectangle = p.getTarget();
			if(gato.left > plat.right || gato.right < plat.left) {			
				context.contact = p;
				context.fall(); // me cai del lado	
			}
		}

	}
}