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
			logger.info("gameController initiated");
			
		}
		
		private function onMapReady(e:Event):void
		{
			logger.info("map is ready: ");			
			createNewLevel();
		}
		
		private function createNewLevel():void{
			logger.info("createNewLevel: ");
			level = new Level(levelCreator.getLevelDefinition(LevelCreator.EASY));
			level.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addChild(level);
		}
		
		private function onEnterFrame(e:Event):void
		{
			level.onEnterFrame(e);
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