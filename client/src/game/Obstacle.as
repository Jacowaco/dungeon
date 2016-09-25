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
		private var isOver:Boolean = false;
		private var isActive:Boolean = true;
		
		public var touched:Boolean = false; 
		
		public static var VANISH:String = "vanish";
		public static var MOBILE:String = "mobile";
		public static var STATIC:String = "static";
		
		public static var GOAL:String = "goal";
		public static var FLOOR:String = "floor";
		public static var OBSTACLE:String = "obstacle";
		
		private var kind:String = "";
		private var asset:MovieClip;
		
		public var pos:Vector2D;
		var offset:Point = new Point();
		
		public function Obstacle(mc:MovieClip)
		{			
			asset = mc;
			this.name = asset.name;
			this.addChild(mc);
		}
		
		public function type():String
		{
			return asset.name;
		}
		
		public function debug():void
		{
			asset.gotoAndPlay(2);
		}
		
	
		
		public function triggerAction():void
		{
			
			on();
			
			switch(kind)
			{
				case VANISH:
				{
					dismiss();		
					break;
				}
					
				case MOBILE:
				{
					
					break;
				}
					
				case STATIC:
				{
					
					break;
				}
					
				default:
				{
					break;
				}
			}
			
			
			
			
			
		}
		
		public function on():void
		{
			asset["ison"].visible = true;	
			touched = true;
			isOver = true;				
		}
		
		public function off():void
		{
			asset["ison"].visible = false;
			isOver = false;
		}
		
		
		
		
		public function isOn():Boolean
		{
			return isOver;
		}
		
		
		public function dismiss():void
		{
			var fadeOut:Tween = new Tween(asset, 700, {alpha:0});
			fadeOut.addEventListener(TaskEvent.COMPLETE, setOff);
			Game.taskRunner().add(fadeOut);			
		}
		
		private function setOff(e:Event):void
		{
			//			trace("platform set off");
			off();
			
		}
		
		public function set active(a:Boolean):void
		{
			isActive = a;
		}
		
		public function get active():Boolean
		{
			return isActive;
		}
		
		
		public function isGoal():Boolean
		{
			return kind == GOAL;
		}
		
		
		public function reset():void
		{
			asset.alpha = 1;
			active = true;
			off();
		}
		
		
	}
}