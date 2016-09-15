package game
{
	import avtr.Avatar;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
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
//				return obj.hitTestPoint(avatar.localToGlobal(new Point()).x, avatar.localToGlobal(new Point()).y, true);
				if(obj.hitTestObject(avatar)){
					trace (obj.toString());
					return true;
				}
				
			}
			return false;
		}
	}
}