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
			
			avatar = new Avatar();
			
			addChild(avatar);
			
			
			
			
		}
		
		private function onMapReady(e:Event):void
		{
			trace("map ready: ");			
			screens.push(new Screen(levels.getLayer("level_1")));
//			screens.push(new Screen(levelDefinition.getLayer("level_2")));
			addChild(screens[0]);
//			addChild(screens[1]);
			//setInterval(switchScreen, 2000);
			collisions = new CollisionManager(screens[0] as Screen);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			avatar.update();
			if(collisions.floorCollision(avatar)){
				avatar.isOverFloor();
			}
			
	
			
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
			avatar.key_down(key);
		}
		
		public function keyUp(key:KeyboardEvent):void
		{
			avatar.key_up(key);	
		}
	}
}