package game
{
	import assets.*;
	
	import avtr.Avatar;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.setInterval;
	
	import tiles.Screen;
	import tiles.TileMap;
	
	import utils.Utils;
	
	public class Level extends Sprite
	{
		private var levels:TileMap;
		private var screens:Array = [];
		private var avatar:Avatar;
		private var collisions:CollisionManager;
		
		public function Level()
		{
			super();			
			levels = new TileMap(Game.path("./tiles/"), "levels.json");
			levels.addEventListener(TileMap.MAP_READY, onMapReady);
			
			
		}
		
		private function onMapReady(e:Event):void
		{
			trace("map ready: ");			
			screens.push(new Screen(levels.getLayer("level_1")));
			addChild(screens[0]);
			collisions = new CollisionManager(screens[0] as Screen);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			avatar = new Avatar();			
			avatar.position = (screens[0] as Screen).startPos;
			addChild(avatar);
			
			

		}
		
		private function onEnterFrame(e:Event):void
		{
			
			if( ! collisions.floorCollision(avatar)) avatar.setFallState();
			avatar.update();
			
		}
		
		
		// engania piuchanga para prbar
		private var flag:Boolean = false;		
		private function switchScreen():void
		{
			flag = !flag;
			if(flag){
				removeChild(screens[0]); addChild(screens[1]);				
				
			}else
			{
				removeChild(screens[1]); addChild(screens[0]);
			}
		}
		
		public function keyDown(key:KeyboardEvent):void
		{
			avatar.onKeyDown(key);

		}
		
		public function keyUp(key:KeyboardEvent):void
		{
			avatar.onKeyUp(key);	
		}
	}
}