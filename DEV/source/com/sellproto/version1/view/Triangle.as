package com.sellproto.version1.view
{

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import gs.*;
	import gs.easing.*;
	import com.sellproto.version1.events.*;

	public class Triangle extends MovieClip
	{
		private var _size:Number;
		private var _id:int;
		private var _direction:String;
		private var _evtObj:Object;
        
        public function Triangle()
        {
			trace("Triangle()");
        	super();
			initAll();
        }
		
		private function initAll():void
		{
			addEventListener(MouseEvent.CLICK, click_handler);
			addEventListener(MouseEvent.MOUSE_OVER, over_handler);
			addEventListener(MouseEvent.MOUSE_OUT, out_handler);
			buttonMode = true;
			mouseEnabled = true;
			useHandCursor = true;
		}
		
		public function setDirection(which:String):void
		{
			_direction = which; //'left' or 'right'
			if(_direction == "left")
			{
				_id = 1;
			}
			else
			{
				_id = 2;
			}
		}
		
		public function setBox(boo:Boolean):void
		{
			if(boo)
			{
				addEventListener(MouseEvent.CLICK, click_handler);
				addEventListener(MouseEvent.MOUSE_OVER, over_handler);
				addEventListener(MouseEvent.MOUSE_OUT, out_handler);
				buttonMode = true;
				mouseEnabled = true;
				useHandCursor = true;
				this.alpha=1;
			}
			else
			{
				removeEventListener(MouseEvent.CLICK, click_handler);
				removeEventListener(MouseEvent.MOUSE_OVER, over_handler);
				removeEventListener(MouseEvent.MOUSE_OUT, out_handler);
				buttonMode = false;
				mouseEnabled = false;
				useHandCursor = false;
				TweenMax.to(this, .2, {glowFilter:{color:0x8989F5, alpha:0, blurX:0, blurY:0}});
				this.alpha=.2;
			}
		
		}
		
		private function over_handler(event:MouseEvent):void
		{
			//trace("over id: " + id);
			//TweenMax.to(this, .4, {x:_underX+_width, ease:Quint.easeIn});
			TweenMax.to(this, .5, {glowFilter:{color:0x8989F5, alpha:1, blurX:20, blurY:20}});
		}
		
		private function out_handler(event:MouseEvent):void
		{
			//trace("over id: " + id);
			//TweenMax.to(this, .4, {x:_underX, ease:Quint.easeIn});
			TweenMax.to(this, .5, {glowFilter:{color:0x8989F5, alpha:0, blurX:0, blurY:0}});
		}
		
		private function click_handler(event:MouseEvent):void
		{
			//trace("hit id: " + id);
			dispatchEvent(new NavEvent(NavEvent.BOTNAV, _id, _evtObj));
		}
	
	
	}

}

