package game
{
	import com.qb9.flashlib.easing.Tween;
	import com.qb9.flashlib.geom.Vector2D;
	import com.qb9.flashlib.motion.MoveTo;
	import com.qb9.flashlib.tasks.Loop;
	import com.qb9.flashlib.tasks.Sequence;
	import com.qb9.flashlib.tasks.TaskEvent;
	import com.qb9.flashlib.tasks.Wait;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	import flash.utils.setTimeout;
	
	public class Obstacle extends Sprite
	{
		
		private var isKiller:Boolean 	= false;   // lo toco y muero
		private var isActive:Boolean	= false; 	// si lo toqué, puedo activar una animacion (ie: un obstaculo que es floor pero luego es killer)
		private var isZombie:Boolean	= false;	// el tile cambia de estado killer automaticamente
		private var isMobile:Boolean	= false;    // si quiero que se mueva solo por la pantalla
		
		
		public static var GOAL:String = "goal";

		// estos nombres los uso para parsear el objeto y configurarlo
		public static var FLOOR:String 					= "floor";   // es el piso.       
		public static var BRICK:String 					= "brick";   // ladrillos: puedo chocarlos de lado
		public static var PIT:String					= "pit"; 	// es un agujero en el piso que tiene un killer
		public static var TRICK_FLOOR:String			= "trickFloor"; // es el piso que te cambia y te mata
		public static var ZOMBIE:String 				= "zombie";
		public static var BAT:String					= "bat";
		public static var HOOK:String					= "hook";
		
		protected var asset:MovieClip;
		protected var myType:String;
		
		// Obstacle responde mas o menos al patron Decorator
		// ver https://sourcemaking.com/design_patterns/decorator
		public function Obstacle(mc:MovieClip)
		{	
			// duando recibo el objeto, en base al nombre 
			// me configuro como un obstaculo particular
			asset = mc;
			this.name = asset.name;						
			this.addChild(mc);
		}
		
		public static function create(mc:MovieClip):Obstacle
		{
			
			switch (mc.name){
				case Obstacle.FLOOR:
						return new Floor(mc);
					break;
				case Obstacle.BRICK:
						
					break;									
				
				
				case Obstacle.PIT:
			
					break;
			}
			
			return new Obstacle(mc);
		}
		
		
		public function debug():void
		{
			asset.gotoAndPlay("debug");
		}
		
		public function get type():String
		{
			return name;
		}
	
		// activate lo llamo cada vez que el avatar toda el obstaculo
		// una vez que los activo no vuelven atras...
		public function activate():void
		{
			throw new Error("unimplemented");
		}
		
		public function kills():Boolean
		{
			return isKiller;	
		}
		
		
	}
}