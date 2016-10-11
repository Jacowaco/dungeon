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
	// GameController podria ser un singleton. no va a haber otro mientras dure el juego.
	// ahora lo que hago es que todas las clases extiendan de sprite y se va a la mierda.
	// es lo mas comodo. igual trato de separar lo que es modelo de lo que es vista. pero en general las clases logicas
	// extienden de Sprite o EventDispatcher.
	public class GameController extends Sprite
	{	
		private var levelCreator:LevelBuilder;		
		private var dungeon:PlatformGame;		
		
		public function GameController()
		{
			logger.info("gameController initiated");
			levelCreator = new LevelBuilder();
			levelCreator.addEventListener(LevelBuilder.MAP_IS_READY, onMapReady);
			levelCreator.init();
		}
		
		private function onMapReady(e:Event):void
		{			
			logger.info("game controller is ready");
		}
		
		// por ahora dejo este metodo publico para poder inciar con un boton en la pantalla
		// pero en realidad solo el GameController podría crear un dungeon game.
		public function createNewLevel():void{
			logger.info("createNewLevel: ");
			// el juego va a tener 3 niveles, easy, med, hard	
			if(dungeon) {
				// por ahora para resetear y probar lo quemo (lo tiro a null)
				// como no le registré ningún evento a ese objeto estoy casi seguro que se destruye por completo
				// igual tendría que profilear.
				removeChild(dungeon);
				dungeon = null;
			}
			// aca se separa todo. me chupa un huevo como creo el nivel, en tanto y en cuanto
			// le pase a platformGame una secuencia de pantallas (TileLayers);
			dungeon = new PlatformGame(levelCreator.getLevelDefinition(LevelBuilder.EASY));			
			addChild(dungeon);
		}
		
		public function onEnterFrame(e:Event):void
		{
			if(dungeon){
				dungeon.onEnterFrame(e);
			}
		}
		
		public function onKeyDown(key:KeyboardEvent):void
		{
			if(dungeon){
				dungeon.onKeyDown(key);
			}
			
		}
		
		public function onKeyUp(key:KeyboardEvent):void
		{
			if(dungeon){
				dungeon.onKeyUp(key);	
			}
		}
		
	}
}