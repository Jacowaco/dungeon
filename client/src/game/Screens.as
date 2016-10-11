package game
{
	import com.qb9.flashlib.lang.foreach;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import tiles.TileLayer;

	
	public class Screens extends Sprite
	{
		private var screens:Array;
		private var flag:Boolean = false;		

		// todas las pantallas puestas una a continuacion de la otra
		public function Screens(levelDef:Array)
		{
			logger.info("Screens");			
			screens = [];
			for each(var layer:TileLayer in levelDef){
				logger.info("creating screen:" + layer);
				screens.push(new Screen(layer));												
			}
			
			// esto esta bien pero habrá que mejorarlo para cada tipo de juego
			// es arbitrario como se ordenan las screens.
			var id:int = 0;
			for each(var s:Screen in screens){				
				s.x = id * s.dimension.x;
				if(screens.length > 0) {
					addChild(s);	
				}
				id++;
			}
		}
		
		public function dispose():void
		{
			for each(var s:Screen in screens){				
				s.dispose();
			}
		}
		
		public function getScreens():Array			
		{
			return screens;
		}

	}
}