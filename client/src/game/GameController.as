package game
{
	import avtr.Avatar;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import tiles.TileMap;
	
	// GameController es experimental
	// quiero ver si me sirve tener un controlador entre game y el juego
	// en este caso tengo que agregar un generador de niveles porque necesito generar niveles al azar. (esto tiene toda una lógica)
	// ademas como estoy usando Tiled, tambien tengo que interfasear la data del tiled (json) con los assets en flash. 
	// (no es una opción rasterizar porque los pibes juegan a pantalla completa)
	
	public class GameController extends Sprite
	{
	
		private var levelCreator:LevelBuilder;
		
		public var level:Level;		
		
		public function GameController()
		{
			logger.info("gameController initiated");
			levelCreator = new LevelBuilder();
			levelCreator.addEventListener(LevelBuilder.MAP_IS_READY, onMapReady);
			levelCreator.init();
			
			
		}
		
		private function onMapReady(e:Event):void
		{			
			logger.info("onMapReady");
			createNewLevel();
		}
		
		private function createNewLevel():void{
			logger.info("createNewLevel: ");
			// el juego va a tener 3 niveles, easy, med, hard			
			level = new Level(levelCreator.getLevelDefinition(LevelBuilder.EASY));			
			addChild(level);
		}
		
		
		public function onGuiEvent(e:Event):void
		{
				
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