package com.ddiggs.transitions.view
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import gs.*;
	import gs.easing.*;
	import com.ddiggs.transitions.events.CustomEvent;

	public class BasicButton extends MovieClip
	{
		private var _id:int;
		//private var _label_str:String;
		private var _evtObj:Object;
		private var _bk:MovieClip;
        
        public function BasicButton()
        {
			trace("BasicButton()");
        	super();
        }
		
		public function setButton(id:int):void
		{
			_id = id;
			//_label_str = label;
			//_label.text = _label_str;
		
			addEventListener(MouseEvent.CLICK, click_handler);
			addEventListener(MouseEvent.MOUSE_OVER, over_handler);
			addEventListener(MouseEvent.MOUSE_OUT, out_handler);
			
			buttonMode = true;
			mouseEnabled = true;
			useHandCursor = true;
		}
		
		public function setButtonVarObject(evtObj:Object):void
		{
			_evtObj = evtObj;
		}
		
		
		private function over_handler(event:MouseEvent):void
		{
			TweenMax.to(this, .2, {glowFilter:{color:0x8989F5, alpha:1, blurX:20, blurY:20}, alpha:1});
		}
		
		private function out_handler(event:MouseEvent):void
		{
			TweenMax.to(this, .4, {glowFilter:{color:0x8989F5, alpha:0, blurX:0, blurY:0}, alpha:.9});
		}
		
		private function click_handler(event:MouseEvent):void
		{
			trace("hit a button id: " + _id);
			//_evtObj.id = _id;
			dispatchEvent(new CustomEvent("NavEvent", {id:_id}));
		}
	}
}

