package com.sellproto.version1.view
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import gs.*;
	import gs.easing.*;
	import com.sellproto.version1.events.*;

	public class LeftButton extends MovieClip
	{
		private var _size:Number;
		private var _id:int;
		private var _label_str:String;
		private var _width:Number;
		private var _height:Number;
		private var _newY:Number;
		private var _clickHeight:Number;
		private var _normalY:Number;
		private var _totalHeight:Number;
		private var _isReady:Boolean = false;
		private var _evtObj:Object;
        
        public function LeftButton()
        {
			trace("LeftButton()");
        	super();
			_glow.alpha=0;
        }
		
		public function setButton(id:int, label:String):void
		{
			_id = id;
			_label_str = label;
			
			_label.text = _label_str;
			_width = width;
			_height = height;
			
			addEventListener(MouseEvent.CLICK, click_handler);
			addEventListener(MouseEvent.MOUSE_OVER, over_handler);
			addEventListener(MouseEvent.MOUSE_OUT, out_handler);
			buttonMode = true;
			mouseEnabled = true;
			useHandCursor = true;
		}
		
		public function setHeight(newHeight:Number):void
		{
			_height = newHeight;
			_mid.height = _height - (2 * _top.height)+4;
			_bot.y = _mid.height + _top.height-6;
			_totalHeight = _bot.y + _bot.height;
		}
		
		public function isSelected(boo:Boolean):void
		{
			if(boo)
			{
				TweenMax.to(_glow, .5, {alpha:0});
				TweenMax.to(_hrule, .5, {alpha:.7});
				removeEventListener(MouseEvent.CLICK, click_handler);
				removeEventListener(MouseEvent.MOUSE_OVER, over_handler);
				removeEventListener(MouseEvent.MOUSE_OUT, out_handler);
				buttonMode = false;
				mouseEnabled = false;
				useHandCursor = false;
			}
			else
			{
				TweenMax.to(_hrule, .5, {alpha:0});
				addEventListener(MouseEvent.CLICK, click_handler);
				addEventListener(MouseEvent.MOUSE_OVER, over_handler);
				addEventListener(MouseEvent.MOUSE_OUT, out_handler);
				buttonMode = true;
				mouseEnabled = true;
				useHandCursor = true;
			}
		}
		
		public function setReady():void
		{
			_isReady = true;
			
		}
		
		private function over_handler(event:MouseEvent):void
		{
			TweenMax.to(_glow, .5, {alpha:.3});	
		}
		
		private function out_handler(event:MouseEvent):void
		{
			TweenMax.to(_glow, .5, {alpha:0});
		}
		
		private function click_handler(event:MouseEvent):void
		{
			//trace("hit id: " + id);
			if(_id == 2 || _id ==3)
			{
				if(_isReady)
				{
					parent.addChild(this);
				}
			}
			else
			{
				parent.addChild(this);
			}
			
			var $tmp:Object = new Object;
			$tmp.height = _totalHeight;
			
			dispatchEvent(new NavEvent(NavEvent.LEFTNAV, _id, _evtObj));
		}
	}
}

