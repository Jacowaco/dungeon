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
			switch ((screen.getChildAt(i) as Thing).name){
				case "floor":
					floor.push(screen.getChildAt(i));
				break;
				case "obstacle":
					obstacle.push(screen.getChildAt(i));
				break;
			}
		 }
		 
		 trace(floor.length);
		 trace(obstacle.length);
		}
		
		
		public function checkFloor(avatar:Avatar):Boolean
		{
			for each(var obj:Thing in floor){
				if(checkTopCollition(obj, avatar)) return true;
			}

			return false;
		}
		

		private function checkTopCollition(obj:Thing, avatar:Avatar):Boolean
		{
			var point:Point = avatar.target(Avatar.BOTTOM).localToGlobal(new Point());
			
			if(obj.hitTestPoint( point.x, point.y, true)){						
				avatar.moveBy(0, obj.getBounds(obj.stage).top - avatar.target(Avatar.BOTTOM).localToGlobal(new Point).y);  // fuerzo a que el gato se pare en la plataforma
				avatar.move();
				obj.debug();
				return true;
			} 
			
			return false;
		}
		
		public function checkObstacles(avatar:Avatar):Boolean
		{
			for each(var obj:Thing in obstacle){
				if(checkSideCollition(obj, avatar)) return true;
				if(checkTopCollition(obj, avatar)) return true;
			}
			return false;
		}
		
		private function checkSideCollition(obj:Thing, avatar:Avatar):Boolean
		{
			var dir:int = avatar.facingRight() ? 1 : -1  ;			
			var target:Point = avatar.target(Avatar.RIGHT).localToGlobal(new Point);// avatar.target(dir ? Avatar.RIGHT : Avatar.LEFT).localToGlobal(new Point);  siempre es right			
			if(obj.hitTestPoint(target.x, target.y)){		
				var collider:Number = dir == 1 ? obj.getBounds(obj).left : obj.getBounds(obj).right;
				avatar.moveBy(collider - target.x, 0);  
				obj.debug();
				return true;
			}
			return false;
				
		}
		
	}
}