package com.sellproto.version1.view
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import gs.*;
	import gs.easing.*;
	import com.sellproto.version1.events.*;

	public class BasicButton extends MovieClip
	{
		private var _id:int;
		private var _label_str:String;
		private var _evtObj:Object;
        
        public function BasicButton()
        {
			trace("LeftButton()");
        	super();
        }
		
		public function setButton(id:int, label:String):void
		{
			_id = id;
			_label_str = label;
			_label.text = _label_str;
		
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
		
		public function setWidth(newwidth:Number):void
		{
			
			_bk.width = newwidth;
		}
		
		private function over_handler(event:MouseEvent):void
		{
			TweenMax.to(this, .2, {glowFilter:{color:0x8989F5, alpha:1, blurX:10, blurY:10}});
		}
		
		private function out_handler(event:MouseEvent):void
		{
			TweenMax.to(this, .4, {glowFilter:{color:0x8989F5, alpha:0, blurX:0, blurY:0}});
		}
		
		private function click_handler(event:MouseEvent):void
		{
			trace(_label_str + " hit!!");
			dispatchEvent(new NavEvent(NavEvent.BASICBUT, _id, _evtObj));
		}
	}
}

