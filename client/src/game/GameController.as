package game
{
	import avtr.Avatar;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import tiles.TileMap;

	public class GameController extends Sprite
	{
		public var level:Level;		
		private var levelCreator:LevelCreator;
		public function GameController()
		{
			levelCreator = new LevelCreator();
			levelCreator.addEventListener(LevelCreator.MAP_IS_READY, onMapReady);
			levelCreator.init();
			
		}
		
		private function onMapReady(e:Event):void
		{
			trace("map ready: ");			
			level = new Level(levelCreator.getLevelDefinition(LevelCreator.EASY));
			addChild(level);
		}
		
		

		
		public function keyDown(key:KeyboardEvent):void
		{
			level.keyDown(key);
			
		}
		
		public function keyUp(key:KeyboardEvent):void
		{
			level.keyUp(key);	
		}

	}
}