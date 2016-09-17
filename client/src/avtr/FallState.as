package avtr
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import game.Thing;
	
	
	
	public class FallState extends AvatarState
	{
		public function FallState(context:Avatar){
			this.context = context;
		}
		
		override public function enter():void{
//			logger.info("enter fall state");			
		}
		
		override public function exit():void{
//			logger.info("exit fall state");
		}
		
		// fall state solo lo hace caer
		override public function update(keys:Object):void{						
			// actualizo la fuerza de gravedad
			var gforce:Vector2D = context.g; //.scaled(1/context.m);
			context.vel = context.vel.add(gforce);
			// actualizo la fuerza lateral reseteandola (para que no se acumule velocity en x)
			var sideForce:Vector2D = new Vector2D(resolveDirection(keys).x * context.sideForce, 0);
//			sideForce = sideForce.scaled(context.m);
			// el velocity se actauliza pero no acumulu fuerzas de aceleraciones
			context.vel = new Vector2D(sideForce.x, context.vel.y);
			context.position = context.position.add(context.vel);
		}
		
				
		override public function handleCollition(p:Thing):void
		{
			var gato:Rectangle = context.getTarget();
			var plat:Rectangle = p.getTarget();
			// voy a chocar contra esta plataforma			
			if(plat.top - gato.bottom < 10 ){
//				trace("over");
				context.vel = new Vector2D(context.vel.x, 0);
				context.moveBy(0, plat.top - gato.bottom);  // fuerzo a que el gato se pare en la plataforma				
				p.triggerAction();
				context.contact = p;
				context.idle();				
			}
			
		}
		
		override public function onKeyDown(ke:KeyboardEvent):void
		{
			if(ke.keyCode == Keyboard.SPACE) {
				// no puedo saltar
				return;
			}
			
			if(ke.keyCode == Keyboard.LEFT || ke.keyCode == Keyboard.RIGHT){
				// tampoco caminar
				return;
			}
		}
		
		override public function onKeyUp(ke:KeyboardEvent):void{}
		
	}
}