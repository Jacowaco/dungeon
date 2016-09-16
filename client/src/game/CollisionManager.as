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
		public static const TOP:int = 1;
		public static const BOTTOM:int = 2;
		public static const LEFT:int = 3;
		public static const RIGHT:int = 4;
		
		
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
			}
			return false;
		}
		
		private function checkTopCollition(obj:DisplayObject, avatar:Avatar):Boolean
		{
			if(obj.hitTestObject(avatar.bottomTarget())){		
				// si lo toque, me tengo que asegurar de que me deje bien parado
				// la colisión se puede registrar recien mucho despues de que el pie atraveso el bounding
				// del obstaculo
				var y:Number = getObjectBoundingSide(obj, TOP);
				avatar.isOverFloor();
				avatar.setPosition(avatar.x, y);				
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
				case TOP:
				{
					return rect.top;
					break;
				}
				case BOTTOM:
				{
					return rect.bottom;
					break;
				}
				case LEFT:
				{
					return rect.left;
					break;
				}
				case RIGHT:
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