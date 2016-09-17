package avtr
{
	import assets.GaturroMC;
	
	import com.qb9.flashlib.geom.Vector2D;
	import com.qb9.flashlib.prototyping.shapes.Rect;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import game.Thing;
	

	
	public class Avatar extends Sprite
	{		
		private static var LEFT:int = -1;
		private static var RIGHT:int = 1;
		
		protected var currentState:AvatarState;
		
		private var idleState:IdleState;
		private var walkingState:WalkState;
		private var jumpingState:JumpState;
		private var fallingState:FallState;
		
		private var keys:Object = {};  // guardo el estado de las keys para saber que hacer en el update
		
		private var walkSpeed:Number;
		public var jumpForce:Number;
		public var sideForce:Number;
		
		private var initialPosition:Vector2D;
		public var contact:Thing; // la cosa contra la que estoy topado ahora.
		
		private var pos:Vector2D;
		public var vel:Vector2D;
		public var g:Vector2D;
		public var f:Vector2D;
		private var asset:MovieClip;
		public function Avatar()
		{
			
			asset = new GaturroMC;
			addChild(asset);
			
			pos = new Vector2D(15,15); // TODO
			vel = new Vector2D();						
			g = new Vector2D(settings.avatar.gravity[0], settings.avatar.gravity[1]);
			f = new Vector2D();
			
			jumpForce = settings.avatar.jump;
			walkSpeed = settings.avatar.speed;
			
			idleState = new IdleState(this);			
			walkingState = new WalkState(this);
			jumpingState = new JumpState(this);
			fallingState = new FallState(this);
			changeState(fallingState); 			
		}
		
		public function update():void
		{
			
//			checkCollisions(platforms);
//			checkGameStatus(platforms);
			currentState.update(keys);
			x = pos.x;
			y = pos.y;
//			super.run(); // para que actualice la posicion del asset
		}
				
		private function checkCollisions(platforms:Array):void{
			currentState.checkCollisions(platforms);
		}
		
		private function checkGameStatus(platforms:Array):void
		{
			for each(var p:Thing in platforms){
//				trace("p.isGoal(): ", p.isGoal());
//				if(p.isGoal() && asset.hitTestObject(p.asset)) {					
//					dispatchEvent(new Event(LevelEvents.LEVEL_WIN));
//					return;
//				}
//				
//				if(asset.localToGlobal(new Point(0, 0)).y > Game.SCREEN_HEIGHT) {
//					dispatchEvent(new Event(LevelEvents.LEVEL_LOST));
//					return;
//				}
			}
		}
		
		public function isFalling():Boolean
		{
			return currentState == fallingState;
		}
		
		
		
		public function setInitialPosition(loc:Vector2D):void
		{
			initialPosition = loc;				
		}
		
		public function direction(direction:int):void
		{
			asset.scaleX = Math.abs(asset.scaleX) * direction;	
		}
		
		public function reset():void
		{
			this.pos = initialPosition;
			changeState(fallingState);
		}
		
		
		
		
		
		
		public function onKeyUp(ke:KeyboardEvent):void{	
			delete keys[ke.keyCode];
			currentState.onKeyUp(ke);
		}
		
		public function onKeyDown(ke:KeyboardEvent):void
		{
			
			switch (ke.keyCode ) {
				case Keyboard.LEFT:
					direction(LEFT);
					break;
				case Keyboard.RIGHT:
					direction(RIGHT);
					break;
			}
			
			keys[ke.keyCode] = 1;	
			currentState.onKeyDown(ke);
		}
		
		protected function changeState(state:AvatarState):void
		{
			if(currentState) currentState.exit();
			currentState = state;
			currentState.enter();
		}
		
		public function jump():void{
			changeState(jumpingState);		
			
		}
		
		public function triggerJumpAnimation():void
		{
			asset.gotoAndPlay("jump");
		}
		
		public function walk():void{
			changeState(walkingState);
			asset.gotoAndPlay("walk");
		}
		
		public function idle():void{
			changeState(idleState);
			asset.gotoAndStop("standBy");
		}
		
		public function fall():void{
			changeState(fallingState);
			asset.gotoAndPlay("falling");
		}
		
		
		public function get speed():Number{
			return walkSpeed;
		}
		
		
		public function getTarget():Rectangle
		{
			var target:MovieClip = asset["target"];			
			return  target.getBounds(target.stage);
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

	}
}