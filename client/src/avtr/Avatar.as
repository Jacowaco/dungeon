package avtr
{
	import assets.*;
	
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
	
	
	
	public class Avatar extends Sprite
	{		
		
		private var left:Boolean;
		private var up:Boolean;
		private var right:Boolean;
		private var space:Boolean;
		private var jumping:Boolean = false;
		
		private var speed:Number;		
		private var jump:Number;		
		private var weight:Number;
		
		private var initialPosition:Vector2D;
		private var asset:MovieClip;
		private var body:Body;
		
		public function Avatar()
		{
			this.asset = new assets.GaturroMC;
			addChild(asset);
			body = new Body();			
			speed = settings.avatar.speed;
			jump = settings.avatar.jump;
		}
		
		public function update():void
		{
			move();
			
			body.update();
			
			x = body.x;
			y = body.y;
			
		}
		
		private function move():void
		{			
			var xs = (left ? -1 : 0 + right ? + 1 : 0) * speed / 10;
			body.velocity = new Vector2D(xs, body.velocity.y);
			
			if(up && !jumping){
				jumping = true;
				asset.gotoAndPlay("jump");
				body.velocity = body.velocity.add(new Vector2D(0, -jump));
			}
			
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
			//			this.loc = initialPosition;
			//			changeState(fallingState);
		}
		
		
		
		public function bottomTarget():DisplayObject
		{
			return asset.foot1;
		}
		
		
		//		public function onKeyUp(ke:KeyboardEvent):void{	
		//			delete keys[ke.keyCode];
		//			currentState.onKeyUp(ke);
		//		}
		//		
		public function key_down(event:KeyboardEvent){
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
		
		public function key_up(event:KeyboardEvent){
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
		
		//		protected function changeState(state:AvatarState):void
		//		{
		//			if(currentState) currentState.exit();
		//			currentState = state;
		//			currentState.enter();
		//		}
		//		
		//		public function jump():void{
		//			changeState(jumpingState);		
		//			
		//		}
		//		
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
		
		
//		public function get speed():Number{
//			return walkSpeed;
//		}
		
		
		public function getTarget():Rectangle
		{
			var target:MovieClip = asset["target"];			
			return  target.getBounds(target.stage);
		}
		
		public function isOverFloor():void
		{
			body.collide(Body.DOWN);
			jumping = false;
		}
		
		
		
		public function pause():void
		{
			asset.stop();
		}
		
		public function resume():void
		{
			asset.play();
		}
		
		public function setPosition(x:Number, y:Number):void
		{
			body.x = x;
			body.y = y;
		}
		
	}
}