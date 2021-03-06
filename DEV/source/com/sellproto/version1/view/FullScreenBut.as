package com.sellproto.version1.view
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import gs.*;
	import gs.easing.*;
	import com.sellproto.version1.events.*;

	public class FullScreenBut extends MovieClip
	{
		private var _id:int;
		private var _evtObj:Object;
        
        public function FullScreenBut()
        {
			trace("FullScreenBut()");
        	super();
        }
		
		public function setButton(id:int):void
		{
			_id = id;
		
			addEventListener(MouseEvent.CLICK, click_handler);
			addEventListener(MouseEvent.MOUSE_OVER, over_handler);
			addEventListener(MouseEvent.MOUSE_OUT, out_handler);
			buttonMode = true;
			mouseEnabled = true;
			useHandCursor = true;
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
			dispatchEvent(new NavEvent(NavEvent.BASICBUT, _id, _evtObj));
		}
	}
}

