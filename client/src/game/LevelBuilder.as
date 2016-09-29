package game
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	
	import tiles.TileMap;
	
	import utils.Utils;

	// esta clase es mas o menos un builder:
	// https://sourcemaking.com/design_patterns/builder
	public class LevelBuilder extends EventDispatcher
	{
		public static const EASY:String = "easy";
		public static const MAP_IS_READY:String = "mapIsReady";
		private var screenNumber:int = 0;
		private var levels:TileMap;		

		public function LevelBuilder()
		{

		}
		
		private function onMapReady(e:Event):void
		{
			dispatchEvent(new Event(LevelBuilder.MAP_IS_READY));
		}
		
		public function init():void
		{
			levels = new TileMap(Game.path("./tiles/"), "levels.json");
//			trace("levels.numLayers:",levels.numLayers);
			levels.addEventListener(TileMap.MAP_READY, onMapReady);				
		}
		
		
		// este es el metodo que crea los niveles, el unico metodo disponible para qeu el game (o quien sea)
		// obtenga un nivel.
		// el level builder va a manejar tambien la lógica de la randomización del nivel.
		// por ahora esta harcodeado como se genera el nivel
		public function getLevelDefinition(difficulty:String):Array
		{
			trace("getLevelDefinition", difficulty);
			var layers:Array = [];
			var list:Array =  settings.level;
			
			
			
			for each(var name:String in list){
//				trace(name);
//				trace(Utils.getProperties( levels.getLayers()));
//				trace(levels.getLayers()[name]);
				layers.push(levels.getLayers()[name]);
			}
			return layers;
		}
		
	}
}