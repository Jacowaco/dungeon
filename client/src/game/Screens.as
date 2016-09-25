package game
{
	import com.qb9.flashlib.lang.foreach;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import tiles.TileLayer;

	
	public class Screens extends Sprite
	{
		private var screens:Array;
//		private var currentScreen:int = 0;
		private var flag:Boolean = false;		

		// todas las pantallas puestas una atras de la otra
		public function Screens(levelDef:Array)
		{
			logger.info("Screens");			
			var id:int = 0;
			screens = [];
			for each(var layer:TileLayer in levelDef){
				logger.info("creating screen:" + layer);
				var s:Screen = new Screen(layer);
				s.x = id * s.dimension.x;
				s.y = id * s.dimension.y;
				logger.info(s.x, s.y);
				screens.push(s);
				addChild(s);				
				id++;
			}
		}
		

		private function switchScreen():void
		{
			flag = !flag;
			if(flag){
//				removeChild(screens[0]); addChild(screens[1]);				
				
			}else
			{
//				removeChild(screens[1]); addChild(screens[0]);
			}
		}
		
		public function currentScreen():Screen
		{
			return screens[0]; 
		}
		

	}
}