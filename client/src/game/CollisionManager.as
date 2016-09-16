package game
{
	import avtr.Avatar;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import tiles.Screen;
	import tiles.TileLayer;
	import tiles.TileMap;

	public class CollisionManager
	{
		
		private var floor:Array = [];
		private var obstacle:Array = [];
		
		public function CollisionManager(screen:Screen)
		{
			addColliders(screen);
		}
		
		private function addColliders(screen:Screen):void
		{
		 for(var i:int = 0; i < screen.numChildren; i++){
			switch (screen.getChildAt(i).name){
				case "floor":
					floor.push(screen.getChildAt(i));
				break;
				case "obstacle":
					obstacle.push(screen.getChildAt(i));
				break;
			}
		 }
		 
		}
		
		
		public function floorCollision(avatar:Avatar):Boolean
		{
			for each(var obj:DisplayObject in floor){
				if(checkTopCollition(obj, avatar)) return true;
			}

			return false;
		}
		
		public function obstacleCollision(avatar:Avatar):Boolean
		{
			// ENGANA PICHANGA
			for each(var obj:DisplayObject in obstacle){
				if(checkTopCollition(obj, avatar)) return true;		
				if(checkLeftCollition(obj, avatar)) return true;
				if(checkRightCollition(obj, avatar)) return true;
			}
			return false;
		}
		
		private function checkTopCollition(obj:DisplayObject, avatar:Avatar):Boolean
		{
//			trace((avatar.getTarget(Avatar.BOTTOM)).x,(avatar.getTarget(Avatar.BOTTOM)).y );
			if(avatar.isJumping()) return false;
			
			var point:Point = avatar.localToGlobal(new Point());
			if(obj.hitTestPoint( point.x, point.y, true)){
//				trace("true");
				var y:Number = getObjectBoundingSide(obj, Avatar.TOP);
				avatar.setPosition(avatar.getPosition().x, y);				
				(obj as MovieClip).gotoAndPlay(2);
				return true;
			} 
			
			return false;
		}
		
		private function checkLeftCollition(obj:DisplayObject, avatar:Avatar)
		{
			
			if(obj.hitTestPoint( (avatar.getTarget(Avatar.LEFT)).x, (avatar.getTarget(Avatar.LEFT)).y )){		
				// si lo toque, me tengo que asegurar de que me deje bien parado
				// la colisión se puede registrar recien mucho despues de que el pie atraveso el bounding
				// del obstaculo
				var x:Number = getObjectBoundingSide(obj, Avatar.RIGHT);
				avatar.isFacingWall();
				avatar.setPosition(x, avatar.y);				
				(obj as MovieClip).gotoAndPlay(2);
				return true;
			} 
			
			return false;
				
		}
		
		private function checkRightCollition(obj:DisplayObject, avatar:Avatar)
		{
			
			if(obj.hitTestObject(avatar.getTarget(Avatar.RIGHT))){		
				var x:Number = getObjectBoundingSide(obj, Avatar.LEFT);
				avatar.isFacingWall();
				avatar.setPosition(x , avatar.y);				
				(obj as MovieClip).gotoAndPlay(2);
				return true;
			} 
			
			return false;
			
		}
		
		private function getObjectBoundingSide(obj:DisplayObject, side:int):Number
		{
			var rect:Rectangle = obj.getBounds(obj.stage);
			switch(side)
			{
				case Avatar.TOP:
				{
					return rect.top;
					break;
				}
				case Avatar.BOTTOM:
				{
					return rect.bottom;
					break;
				}
				case Avatar.LEFT:
				{
					return rect.left;
					break;
				}
				case Avatar.RIGHT:
				{
					return rect.right;
					break;
				}
					
				default:
				{
					break;
				}
			}
			return 0;
		}
	}
}