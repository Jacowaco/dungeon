package avtr
{
	import assets.GaturroMC;
	
	import com.qb9.flashlib.geom.Vector2D;
	import com.qb9.flashlib.prototyping.shapes.Rect;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import game.CollisionManager;
	import game.PlatformGame;
	import game.obstacles.Obstacle;
	
	import org.as3commons.zip.utils.ChecksumUtil;
	
	
	
	public class Avatar extends Sprite
	{		
		public static var LEFT:int 			= 1;
		public static var RIGHT:int 		= 2;
		public static var BOTTOM:int 		= 3;
		public static var TOP:int 			= 4;
		
		public var left:Boolean = false;
		public var right:Boolean = false;
		public var jump:Boolean = false;
		public var duck:Boolean = false;
		public var shoot:Boolean = false;
		
		
		protected var currentState:AvatarState;
		
		private var idleState:IdleState;
		private var walkingState:WalkState;
		private var jumpingState:JumpState;
		private var fallingState:FallState;
		private var deadState:DeadState;
		
		private var keys:Object = {};  // guardo el estado de las keys para saber que hacer en el update
		
		private var walkSpeed:Number;
		public var jumpForce:Number;
		public var sideForce:Number;
		public var touchingFloor:Boolean;
		
		private var initialPosition:Vector2D;
		public var contact:Obstacle; // la cosa contra la que estoy topado ahora.
		
		private var pos:Vector2D;
		public var vel:Vector2D;
		public var g:Vector2D;
		public var f:Vector2D;
		public var deadVel:Vector2D;
		private var asset:MovieClip;
		private var faceRight:Boolean = true;
		
		private var lives:int = 3;
		
		public function Avatar()
		{
			
			asset = new GaturroMC;
			addChild(asset);
			
			pos = new Vector2D(15,15); // TODO
			vel = new Vector2D();						
			g = new Vector2D(settings.avatar.gravity[0], settings.avatar.gravity[1]);
			f = new Vector2D();
			deadVel = new Vector2D(0, 10);
			
			jumpForce = settings.avatar.jump;
			walkSpeed = settings.avatar.speed;
			
			idleState = new IdleState(this);			
			walkingState = new WalkState(this);
			jumpingState = new JumpState(this);
			fallingState = new FallState(this);
			deadState = new DeadState(this);
			changeState(fallingState); 			
		}
		
		public function update():void
		{						
			//trace("update state: ", currentState);
			currentState.checkState();
			currentState.update();
		}
		
		public function move():void
		{
			position = position.add(vel);
			updatePos();
		}
		
		public function updatePos():void
		{
			x = pos.x;
			y = pos.y;
		}
		
		public function addGravity():void
		{ 
			vel = vel.add(g);
		}
		
		public function addController():void
		{
			var xdir:Number = left ? -1 : 0 + right ? 1 : 0;	
			vel = new Vector2D(xdir * speed, vel.y);
			if(xdir != 0) faceTo(xdir);
			
			//if(jump) setJumpState();
		}
		
		public function isFalling():Boolean
		{
			return currentState == fallingState;
		}
		
		public function isJumping():Boolean
		{
			return currentState == jumpingState;
		}
		
		public function isDead():Boolean
		{
			return currentState == deadState;
		}
		
		public function faceTo(direction:int):void
		{			
			faceRight = direction == 1 ? true : false; 
			asset.scaleX = Math.abs(asset.scaleX) * direction;	
		}
		
		public function facingRight():Boolean
		{
			return faceRight;
		}
		
		protected function changeState(state:AvatarState):void
		{
			if(currentState) currentState.exit();
			currentState = state;
			currentState.enter();
		}
		
		public function setJumpState():void{
			if(!isJumping()) changeState(jumpingState);		
			asset.gotoAndPlay("jump");// trace("gotoAndPlay(jump)");	
		}
		
		
		public function setWalkState():void{
			changeState(walkingState);
			asset.gotoAndPlay("walk");// trace("gotoAndPlay(walk)");
		}
		
		public function setIdleState():void
		{
			changeState(idleState);
			asset.gotoAndStop("standBy");// trace("gotoAndPlay(standBy)");
		}
		
		public function setFallState():void{
			if(! isFalling()) changeState(fallingState);
			//asset.gotoAndPlay("falling");
		}
		
		public function setDeadState():void
		{
			changeState(deadState);
			asset.gotoAndStop("estornudo");// trace("gotoAndPlay(standBy)");
		}
		
		
		public function get speed():Number{
			return walkSpeed;
		}
		
		public function moveBy(dx:Number, dy:Number):void
		{
			pos = pos.add( new Vector2D(dx, dy));
		}		
		
		public function moveTo(x:Number, y:Number):void
		{
			pos = new Vector2D(x, y);
		}		
		
		public function pause():void
		{
			asset.stop();
		}
		
		public function resume():void
		{
			asset.play();
		}
		
		public function get position():Vector2D
		{
			return pos;
		}
		
		public function set position(value:Vector2D):void
		{
			pos = value;
		}
		
		public function stagePos():Point
		{
			return localToGlobal(new Point);
		}
		
		public function getKilled():void
		{
			if (!isDead())
			{
				trace("get Killed");
				dispatchEvent(new Event(PlatformGame.END));
				setDeadState();
			}
		}
		
		public function target(target:int):DisplayObject
		{
			switch(target)
			{
				case BOTTOM:
				{
					return asset.bottom_tg;
					break;
				}
				case TOP:
				{
					return asset.top_tg;
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
				default:
				{
					break;
				}
			}
			return null;
		}
		
		public function onKeyUp(ke:KeyboardEvent):void{	
			switch (ke.keyCode ) {
				case Keyboard.LEFT:
					left = false;
					break;
				case Keyboard.RIGHT:
					right = false;
					break;
				case Keyboard.UP:
					
					break;				
				case Keyboard.DOWN:
					
					break;
				case Keyboard.SPACE:
					jump = false;
					break;
			}
		}
		
		public function onKeyDown(ke:KeyboardEvent):void
		{
			switch (ke.keyCode ) {
				case Keyboard.LEFT:
					left = true;
					break;
				case Keyboard.RIGHT:
					right = true;
					break;
				case Keyboard.UP:
					
					break;				
				case Keyboard.DOWN:
					
					break;
				case Keyboard.SPACE:
					jump = true;
					break;
			}			
		}
	}
}