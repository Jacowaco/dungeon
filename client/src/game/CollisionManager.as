package game
{
	import avtr.Avatar;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import tiles.TileLayer;
	import tiles.TileMap;
	
	public class CollisionManager extends EventDispatcher
	{
		
		private var obstacles:Array = [];
		private var bricks:Array = [];
		private var pits:Array = [];
		private var goal:Object;
		//http://higherorderfun.com/blog/2012/05/20/the-guide-to-implementing-2d-platformers/
		private var currentScreen:Screens;
		private var avatar:Avatar;
		
		public function CollisionManager(screens:Screens, avatar:Avatar)
		{
			currentScreen = screens;
			this.avatar = avatar;
			for each(var s:Screen in screens.getScreens()){
				addColliders(s);
			}	
		}
		
		public function resolve():void
		{		
			check();
			
//			if(check() ) {  // true si estoy parado sobre algo...				
//				avatar.setIdleState();
//				return true;
//			}
//
//			return false;
		}

		
		// me gusta separar los obstaculos porque cada uno tiene cualidades diferentes.
		// entonces esta bueno tratarlos por separado.
		private function addColliders(screen:Screen):void
		{
			for(var i:int = 0; i < screen.numChildren; i++){				
				obstacles.push(screen.getChildAt(i));
			}		 
			trace(obstacles.length);
		}
		
		
		private function check():Boolean
		{
			for each(var obj:Obstacle in obstacles){
				// si es un piso solo me interesa si estoy parado en...
				if(obj.type == Obstacle.FLOOR){				
					// mira que raro esto:
					if (checkTop(obj)) ;//avatar.setIdleState();   // esto anda...
//					return checkTopCollition(obj, avatar);  			// y eso no... entendes ¿por qué? yo no...
				}
				
				// pero si es un ladrillo primero me fijo a los costados
				// y luego arriba
//				if(obj.type == Obstacle.BRICK){
//					if (checkSides(obj)) continue;   // esto anda...					
//					if (checkTop(obj)) continue;   // esto anda...
//				}				

			}
			
			return false;
		}
		
		
		
		private function checkObstacles(avatar:Avatar):Boolean
		{
			for each(var obj:Obstacle in bricks){
				if(checkSides(obj)) return true;
				if(checkTop(obj)) return true;
			}
			return false;
		}
		
		// COLISIONES POR LADO
		// hitTestPoint solo funciona en coordenadas globales.
		// http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/DisplayObject.html#hitTestPoint()
		private function checkTop(obj:Obstacle):Boolean
		{
			var point:Point = avatar.target(Avatar.BOTTOM).localToGlobal(new Point());
			
			if(obj.hitTestPoint( point.x, point.y, true)){
				avatar.moveTo(avatar.position.x, obj.getBounds(currentScreen).top - avatar.target(Avatar.BOTTOM).y);
				avatar.updatePos();
				obj.debug();
				return true;
			} 			
			return false;
		}
		
		private function checkSides(obj:Obstacle):Boolean
		{
			trace("facingR: ", avatar.facingRight() );
			// checo lado derecho
			var trackerR:Point = avatar.target(Avatar.RIGHT).localToGlobal(new Point);
			var trackerL:Point = avatar.target(Avatar.LEFT).localToGlobal(new Point);
			// si mira a la derecha
			// el traker R solo puede chocar con el bound L del obstaculo
			// el traker L solo puede chocar con el bound R del obstaculo
			if(avatar.facingRight()){		
				
				if(obj.hitTestPoint(trackerR.x, trackerR.y)){
					trace("hitting");
					var leftBound:Number = obj.getBounds(currentScreen).left; 
					var newx:Number = leftBound - trackerR.x; // : avatar.target(Avatar.RIGHT).x);
//					avatar.moveTo(newx, avatar.position.y);
					avatar.moveBy(newx, 0);
					avatar.updatePos();					
					obj.debug();
					return true;
				}
				
				if(obj.hitTestPoint(trackerL.x, trackerL.y, false)){								
//					var rightBound:Number = obj.getBounds(currentScreen).right;
//					var newx:Number = rightBound - avatar.target(Avatar.RIGHT).x; // : avatar.target(Avatar.RIGHT).x);
//					avatar.moveTo(newx, avatar.position.y);
//					avatar.updatePos();					
//					obj.debug();
//					return true;
				}
				
			}else{
			// si mira a la izquierda
			// el traker R solo puede chocar con el bound R del obstaculo
			// el traker L solo puede chocar con el bound L del obstaculo
			
				
			}
	//		var newX:Number;
			
			// me voy a mover en contra del lado 
//			var boundarie:Number = avatar.facingRight() ? obj.getBounds(currentScreen).left : obj.getBounds(currentScreen).right;
			
			
			
//			target = avatar.target(Avatar.LEFT).localToGlobal(new Point);
//			if(obj.hitTestPoint(target.x, target.y)){								
//				boundarie = dir == 1 ? obj.getBounds(currentScreen).right : obj.getBounds(currentScreen).left;
//				newX = boundarie + (dir == 1 ? -avatar.target(Avatar.LEFT).x : avatar.target(Avatar.LEFT).x);
//				avatar.moveTo(newX, avatar.position.y);
//				avatar.updatePos();
//				
//				obj.debug();
//				return true;
//			}
			return false;			
		}
		
		
	}
}