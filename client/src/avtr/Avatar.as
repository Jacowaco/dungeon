package avtr
{
	import assets.*;
	
	import com.qb9.flashlib.geom.Vector2D;
	import com.qb9.flashlib.prototyping.shapes.Rect;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	/*
	alta data gato !
	http://higherorderfun.com/blog/2012/05/20/the-guide-to-implementing-2d-platformers/
	http://devmag.org.za/2011/07/04/how-to-design-levels-for-a-platformer/
	http://devmag.org.za/2012/07/19/13-more-tips-for-making-a-fun-platformer/
	http://devmag.org.za/2011/01/18/11-tips-for-making-a-fun-platformer/
	*/
	
	
	public class Avatar extends Sprite
	{		
		
		public static const TOP:int = 1;
		public static const BOTTOM:int = 2;
		public static const LEFT:int = 3;
		public static const RIGHT:int = 4;
		public static var VERTICAL:int = 1;
		public static var HORIZONTAL:int = 2;
		
		protected var pos:Vector2D;		
		protected var grav:Vector2D;
		protected var vel:Vector2D;
		
		private var left:Boolean;
		private var up:Boolean;
		private var right:Boolean;
		private var space:Boolean;
		
		private var jumping:Boolean = false;
		private var overFloor:Boolean = false; 
		private var facingWall:Boolean = false; 
		
		
		private var speed:Number;		
		private var maxSpeed:Number;
		private var jump:Number;		
		private var weight:Number;
		
		
		private var translation:Number;
		private var initialPosition:Vector2D;
		private var asset:MovieClip;

		
		public function Avatar()
		{
			this.asset = new assets.GaturroMC;
			addChild(asset);

			grav = new Vector2D(0, 1);
			vel = new Vector2D(0,0);
			pos = new Vector2D(15,15);
					
			speed = settings.avatar.speed;
			maxSpeed = settings.avatar.maxSpeed;
			jump = settings.avatar.jump;
		}
		
		public function update():void
		{
			this.vel = this.vel.add(this.grav); 
			this.pos = this.pos.add(this.vel);
			
			
		}
		
		public function render():void
		{			
			x = pos.x;
			y = pos.y;		

		}
		public function addForce(x:Number, y:Number):void
		{
			vel = vel.add(new Vector2D(x,y));
		}
		
		public function setForce(x:Number, y:Number):void
		{
			vel = new Vector2D(x,y);
		}
		
		public function actions():void
		{			
			translation = (left ? -1 : 0 + right ? + 1 : 0) * speed / 10;
			setForce(translation,vel.y);
	
			if(up && !jumping){
				trace("jump....");
				jumping = true;
				asset.gotoAndPlay("jump");
				addForce(0, -jump);
				trace(vel);
			}
			
		}
		
//		public function setInitialPosition(loc:Vector2D):void
//		{
//			initialPosition = loc;				
//		}
		
		public function direction(direction:int):void
		{
			asset.scaleX = Math.abs(asset.scaleX) * direction;	
		}
		
		public function reset():void
		{
			//			this.loc = initialPosition;
			//			changeState(fallingState);
		}
		
		
		
		public function getTarget(side:int):DisplayObject
		{
			switch(side)
			{
				case TOP:
				{
					return asset.top_tg;
					break;
				}
				case BOTTOM:
				{
					return asset.bottom_tg;
					break;
				}
				case LEFT:
				{
					return asset.left_tg;
					break;
				}
				case RIGHT:
				{
					return asset.right_tg;
					break;
				}
					
			}
			return null;
			
		}


		public function isJumping():Boolean
		{
			return jumping;
		}
		
		public function triggerJumpAnimation():void
		{
			asset.gotoAndPlay("jump");
		}
		
		public function walk():void{
			//			changeState(walkingState);
			asset.gotoAndPlay("walk");
		}
		
		public function idle():void{
			//			changeState(idleState);
			asset.gotoAndStop("standBy");
		}
		
		public function fall():void{
			//			changeState(fallingState);
			asset.gotoAndPlay("falling");
		}
		
//		public function isOverFloor():void
//		{
//			overFloor = true;
////			body.collide(Body.VERTICAL);
//			
//		}
		
		public function isFacingWall():void
		{
			facingWall = true;
//			body.collide(Body.HORIZONTAL);
		}

		
		public function setPosition(x:Number, y:Number):void
		{
			pos = new Vector2D(x,y); 
			
		}
		
		public function getPosition():Vector2D
		{
			return pos;
		}
		
		public function pause():void
		{
			asset.stop();
		}
		
		public function resume():void
		{
			asset.play();
		}
		
		public function key_down(event:KeyboardEvent):void{
			if(event.keyCode == 37){
				left = true;
			}
			if(event.keyCode == Keyboard.SPACE){
				up = true;
			}
			if(event.keyCode == 39){
				right = true;
			}
		}
		
		public function key_up(event:KeyboardEvent):void{
			if(event.keyCode == 37){
				left = false;
			}
			if(event.keyCode == Keyboard.SPACE){
				up = false;
			}
			if(event.keyCode == 39){
				right = false;
			}
		}
		
	}
}