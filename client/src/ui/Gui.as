package ui
{
	import assets.*;
	
	import com.adobe.serialization.json.JSON;
	import com.qb9.flashlib.lang.AbstractMethodError;
	import com.qb9.flashlib.movieclip.actions.GotoAndStopAction;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.getClassByAlias;
	import flash.utils.getDefinitionByName;
	
	import popups.*;
	
	import utils.Utils;
	
	
	
	
	public class Gui extends Sprite
	{
		private var asset:MovieClip; // la gui completa		
		
		private var exitBtn:MovieClip; 		//	salir en la gui ingame		
		private var meters:MovieClip;    	//	muestra la data del juego actual (metros)
		private var power:MovieClip;		//  la barra de power		
		private var time:MovieClip;    		//	muestra la data del juego actual (tiempo)
		private var countdown:MovieClip;	//  un countdown 
		
		// menues standar
		private var confirmationPopup:McConfirmation;
		
		public function Gui(asset:MovieClip)
		{
			super();
			this.asset = asset;
			createConfirmationPopup();
			createIngameGui();
			addChild(asset);  // asset tiene el marco amarillo			
		}
		
		private function countdownEnded(e:Event):void
		{
			countdown.visible = false;
			dispatchEvent(new Event(GuiEvents.COUNTDOWN_END));						
		}
		
		private function createIngameGui():void
		{
			// boton salir 
			exitBtn = asset.getChildByName("exit") as MovieClip;
			exitBtn.text.text = api.getText(settings.gui.confirmation.exit);
			exitBtn.mouseEnabled = true;
			exitBtn.addEventListener(MouseEvent.CLICK, onExitBtn);
			exitBtn.addEventListener(MouseEvent.ROLL_OVER, onOver);
			exitBtn.visible = false;
			
			// score
			meters = asset.getChildByName("display") as MovieClip;
			meters.label.text = api.getText(settings.gui.score);
			meters.visible = false;
			
			// time
			time = asset.getChildByName("time") as MovieClip;
			time.label.text = api.getText(settings.gui.time);
			time.visible = false;
			
			// power
			power = asset.getChildByName("power") as MovieClip;
			power.visible = false;
			power.stop();			
			
			// countdown
			countdown = asset.getChildByName("countdown") as MovieClip;
			countdown.addEventListener(Event.COMPLETE, countdownEnded);
			countdown.addEventListener("ding", function():void { audio.fx.play("click");});
			countdown.stop();
			countdown.visible = false;
			
		}
		
		public function enable():void
		{
			exitBtn.visible = true;
			exitBtn.text.text = "AGAIN";
		}
	
		private function createConfirmationPopup():void
		{
			confirmationPopup = new McConfirmation();
			confirmationPopup.visible = false;
			confirmationPopup.addEventListener(GuiEvents.EXIT, onConfirmationExit);
			confirmationPopup.addEventListener(GuiEvents.RESUME, onResume);
			addChild(confirmationPopup);			
		}
		
		
		private function ingameData(show:Boolean):void
		{
			time.visible = show;
			meters.visible = show;
			power.visible = show;
			exitBtn.visible = show;
		}

		private function onOver(e:Event):void
		{
			audio.fx.play("rollover");
		}
		
		private function onExitBtn(e:Event):void
		{
			//engania pichanga
//			audio.fx.play("click");
//			confirmationPopup.visible = true;
			dispatchEvent(new Event(GuiEvents.PAUSE));
		}
		
		private function onConfirmationExit(e:Event):void 
		{
			audio.fx.play("click");
			dispatchEvent(new Event(GuiEvents.EXIT));
		}
		
		private function onResume(e:Event=null):void
		{
			audio.fx.play("click");
			confirmationPopup.visible = false;
			dispatchEvent(new Event(GuiEvents.RESUME));
		}
		
		public function showCountDown():void
		{
			countdown.gotoAndPlay(2);
			countdown.visible = true;			
		}
		
		public function reset():void
		{
			exitBtn.visible = true;
		}
		
		public function setTime(currenttime:String):void
		{
			time.value.text = currenttime;
		}
		
		public function setPower(pow:Number):void
		{
			this.power.gotoAndStop( Math.floor(Utils.map(pow, 0, 1, 1, this.power.totalFrames)));	
		}
		
		public function setMeters(score:String):void
		{
			this.meters.value.text = score;
		}		
	}
}