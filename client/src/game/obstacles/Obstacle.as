package game.obstacles
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
	
	import game.obstacles.Brick;
	import game.obstacles.Floor;
	import game.obstacles.Pit;
	
	public class Obstacle extends Sprite
	{
		
		protected var isKiller:Boolean 	= false;   // lo toco y muero
		protected var isActive:Boolean	= false; 	// si lo toqué, puedo activar una animacion (ie: un obstaculo que es floor pero luego es killer)
		
		
		public static var GOAL:String = "goal";

		// estos nombres los uso para parsear el objeto y configurarlo
		public static var FLOOR:String 					= "floor";   // es el piso.       
		public static var BRICK:String 					= "brick";   // ladrillos: puedo chocarlos de lado
		public static var PIT:String					= "pit"; 	// es un agujero en el piso que tiene un killer
		public static var TRICK_FLOOR:String			= "trickFloor"; // es el piso que te cambia y te mata
		public static var ZOMBIE:String 				= "zombie";
		public static var BAT:String					= "bat";
		public static var HOOK:String					= "hook";
		
		// los nombres de los frames que tienen los assets
		public static var IDLE:String					= "idle";
		public static var WARNING:String 				= "warning";
		public static var KILLER:String 				= "killer";
		
		public var asset:MovieClip;
		protected var myType:String;
		
		// puede que tenga que configurarle cosas...
		// de manera externalizada
		protected var settings:Object;
		
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
						return new Brick(mc);
					break;
				case Obstacle.PIT:
						return new Pit(mc);
					break;
				case Obstacle.TRICK_FLOOR:
						return new TrickFloor(mc);
					break;
				case Obstacle.ZOMBIE:
						return new Zombie(mc);
					break;
				case Obstacle.HOOK:
						return new Hook(mc);
					break;
				case Obstacle.BAT:
						return new Bat(mc);
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
		
		// hay obstaculos que necesitan configuración... ie: zombies y tricks y hooks
		public function config(settings:Object):void
		{
			//trace("nothing to configure");
		}
		
		public function kills():Boolean
		{
			return isKiller;	
		}
		
		protected function goIdle():void
		{
			isKiller = false;
			asset.gotoAndStop(IDLE);
			
		}
		
		protected function goWarning():void
		{
			asset.gotoAndStop(WARNING);			
		}
		
		protected function goKill():void
		{
			isKiller = true;
			asset.gotoAndStop(KILLER);
			
		}
		
		
		
		
	}
}