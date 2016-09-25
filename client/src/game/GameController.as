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
			addChild(level);
		}
		
		public function onEnterFrame(e:Event):void
		{
			if(level){
				level.onEnterFrame(e);
			}
		}
		
		public function onKeyDown(key:KeyboardEvent):void
		{
			if(level){
				level.onKeyDown(key);
			}
			
		}
		
		public function onKeyUp(key:KeyboardEvent):void
		{
			if(level){
				level.onKeyUp(key);	
			}
		}
		
	}
}