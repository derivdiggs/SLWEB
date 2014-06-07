package com.sellproto.version1.view
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import gs.*;
	import gs.easing.*;
	import com.sellproto.version1.events.*;

	public class SlideDisControl extends MovieClip
	{
		private var _id:int;
		/*
		private var _beg:MovieClip;
		private var _end:MovieClip;
		
		private var _prev:MovieClip;
		private var _play:MovieClip;
		private var _pause:MovieClip;
		*/
		private var _bk:MovieClip;
		//private var _next:MovieClip;
		private var _width:Number;
		private var _evtObj:Object;
        
        public function SlideDisControl()
        {
			trace("LeftButton()");
        	super();
			_mainControls._next.addEventListener(MouseEvent.CLICK, _nextClick_handler);
			_mainControls._next.addEventListener(MouseEvent.MOUSE_OVER, _nextOver_handler);
			_mainControls._next.addEventListener(MouseEvent.MOUSE_OUT, _nextOut_handler);
			_mainControls._next.buttonMode = true;
			_mainControls._next.mouseEnabled = true;
			_mainControls._next.useHandCursor = true;
			_mainControls._prev.addEventListener(MouseEvent.CLICK, _prevClick_handler);
			_mainControls._prev.addEventListener(MouseEvent.MOUSE_OVER, _prevOver_handler);
			_mainControls._prev.addEventListener(MouseEvent.MOUSE_OUT, _prevOut_handler);
			_mainControls._prev.buttonMode = true;
			_mainControls._prev.mouseEnabled = true;
			_mainControls._prev.useHandCursor = true;
			_mainControls._first.addEventListener(MouseEvent.CLICK, _firstClick_handler);
			_mainControls._first.addEventListener(MouseEvent.MOUSE_OVER, _firstOver_handler);
			_mainControls._first.addEventListener(MouseEvent.MOUSE_OUT, _firstOut_handler);
			_mainControls._first.buttonMode = true;
			_mainControls._first.mouseEnabled = true;
			_mainControls._first.useHandCursor = true;
			_mainControls._last.addEventListener(MouseEvent.CLICK, _lastClick_handler);
			_mainControls._last.addEventListener(MouseEvent.MOUSE_OVER, _lastOver_handler);
			_mainControls._last.addEventListener(MouseEvent.MOUSE_OUT, _lastOut_handler);
			_mainControls._last.buttonMode = true;
			_mainControls._last.mouseEnabled = true;
			_mainControls._last.useHandCursor = true;
			_mainControls._play.addEventListener(MouseEvent.CLICK, _playClick_handler);
			_mainControls._play.addEventListener(MouseEvent.MOUSE_OVER, _playOver_handler);
			_mainControls._play.addEventListener(MouseEvent.MOUSE_OUT, _playOut_handler);
			_mainControls._play.buttonMode = true;
			_mainControls._play.mouseEnabled = true;
			_mainControls._play.useHandCursor = true;
			_mainControls._info.addEventListener(MouseEvent.CLICK, _infoClick_handler);
			_mainControls._info.addEventListener(MouseEvent.MOUSE_OVER, _infoOver_handler);
			_mainControls._info.addEventListener(MouseEvent.MOUSE_OUT, _infoOut_handler);
			_mainControls._info.buttonMode = true;
			_mainControls._info.mouseEnabled = true;
			_mainControls._info.useHandCursor = true;
        }
		
		public function setSlideDisControl(id:int, width:Number):void
		{
			_id = id;
			_width = width;
		}
		
		public function setWidth(newwidth:Number):void
		{
			
			//_bk.width = newwidth;
			//_mainControls.x = (_width - _mainControls.width)/2
			
		}
		
		public function showPlay():void
		{
			_mainControls._pause.alpha = 0;
			_mainControls._play.alpha = 1;
			_mainControls._play.addEventListener(MouseEvent.CLICK, _playClick_handler);
			_mainControls._play.addEventListener(MouseEvent.MOUSE_OVER, _playOver_handler);
			_mainControls._play.addEventListener(MouseEvent.MOUSE_OUT, _playOut_handler);
			_mainControls._play.buttonMode = true;
			_mainControls._play.mouseEnabled = true;
			_mainControls._play.useHandCursor = true;
		}
		
		public function showPause():void
		{
			_mainControls._pause.alpha = 1;
			_mainControls._play.alpha = 0;
			_mainControls._pause.addEventListener(MouseEvent.CLICK, _pauseClick_handler);
			_mainControls._pause.addEventListener(MouseEvent.MOUSE_OVER, _pauseOver_handler);
			_mainControls._pause.addEventListener(MouseEvent.MOUSE_OUT, _pauseOut_handler);
			_mainControls._pause.buttonMode = true;
			_mainControls._pause.mouseEnabled = true;
			_mainControls._pause.useHandCursor = true;
		}
		
		private function _nextOver_handler(event:MouseEvent):void
		{
			TweenMax.to(_mainControls._next, .2, {glowFilter:{color:0x8989F5, alpha:1, blurX:10, blurY:10}});
		}
		
		private function _nextOut_handler(event:MouseEvent):void
		{
			TweenMax.to(_mainControls._next, .4, {glowFilter:{color:0x8989F5, alpha:0, blurX:0, blurY:0}});
		}
		
		private function _nextClick_handler(event:MouseEvent):void
		{
			trace("next hit")
			dispatchEvent(new NavEvent(NavEvent.BASICBUT, 6, _evtObj));
		}
		
		//////////////
		
		private function _prevOver_handler(event:MouseEvent):void
		{
			TweenMax.to(_mainControls._prev, .2, {glowFilter:{color:0x8989F5, alpha:1, blurX:10, blurY:10}});
		}

		private function _prevOut_handler(event:MouseEvent):void
		{
			TweenMax.to(_mainControls._prev, .4, {glowFilter:{color:0x8989F5, alpha:0, blurX:0, blurY:0}});
		}

		private function _prevClick_handler(event:MouseEvent):void
		{
			trace("next hit")
			dispatchEvent(new NavEvent(NavEvent.BASICBUT, 7, _evtObj));
		}
		
		//////////////
		
		private function _firstOver_handler(event:MouseEvent):void
		{
			TweenMax.to(_mainControls._first, .2, {glowFilter:{color:0x8989F5, alpha:1, blurX:10, blurY:10}});
		}

		private function _firstOut_handler(event:MouseEvent):void
		{
			TweenMax.to(_mainControls._first, .4, {glowFilter:{color:0x8989F5, alpha:0, blurX:0, blurY:0}});
		}

		private function _firstClick_handler(event:MouseEvent):void
		{
			trace("next hit")
			dispatchEvent(new NavEvent(NavEvent.BASICBUT, 8, _evtObj));
		}
		
		//////////////
		
		private function _lastOver_handler(event:MouseEvent):void
		{
			TweenMax.to(_mainControls._last, .2, {glowFilter:{color:0x8989F5, alpha:1, blurX:10, blurY:10}});
		}

		private function _lastOut_handler(event:MouseEvent):void
		{
			TweenMax.to(_mainControls._last, .4, {glowFilter:{color:0x8989F5, alpha:0, blurX:0, blurY:0}});
		}

		private function _lastClick_handler(event:MouseEvent):void
		{
			trace("next hit")
			dispatchEvent(new NavEvent(NavEvent.BASICBUT, 9, _evtObj));
		}
		
		private function _playOver_handler(event:MouseEvent):void
		{
			TweenMax.to(_mainControls._play, .2, {glowFilter:{color:0x8989F5, alpha:1, blurX:10, blurY:10}});
		}

		private function _playOut_handler(event:MouseEvent):void
		{
			TweenMax.to(_mainControls._play, .4, {glowFilter:{color:0x8989F5, alpha:0, blurX:0, blurY:0}});
		}

		private function _playClick_handler(event:MouseEvent):void
		{
			trace("next hit")
			dispatchEvent(new NavEvent(NavEvent.BASICBUT, 10, _evtObj));
		}
		
		private function _pauseOver_handler(event:MouseEvent):void
		{
			TweenMax.to(_mainControls._pause, .2, {glowFilter:{color:0x8989F5, alpha:1, blurX:10, blurY:10}});
		}

		private function _pauseOut_handler(event:MouseEvent):void
		{
			TweenMax.to(_mainControls._pause, .4, {glowFilter:{color:0x8989F5, alpha:0, blurX:0, blurY:0}});
		}

		private function _pauseClick_handler(event:MouseEvent):void
		{
			trace("next hit")
			dispatchEvent(new NavEvent(NavEvent.BASICBUT, 10, _evtObj));
		}
		
		private function _infoOver_handler(event:MouseEvent):void
		{
			TweenMax.to(_mainControls._info, .2, {glowFilter:{color:0x8989F5, alpha:1, blurX:10, blurY:10}});
		}

		private function _infoOut_handler(event:MouseEvent):void
		{
			TweenMax.to(_mainControls._info, .4, {glowFilter:{color:0x8989F5, alpha:0, blurX:0, blurY:0}});
		}

		private function _infoClick_handler(event:MouseEvent):void
		{
			trace("next hit")
			dispatchEvent(new NavEvent(NavEvent.BASICBUT, 11, _evtObj));
		}
	}
}

