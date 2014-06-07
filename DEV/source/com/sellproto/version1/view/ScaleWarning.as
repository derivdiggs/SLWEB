package com.sellproto.version1.view
{

import flash.display.*;
import flash.utils.*;
import flash.events.*;
import gs.*;
import gs.easing.*;

	public class ScaleWarning extends MovieClip
	{
		private var _warning_str:String;
		private var _width:Number;
		private var _height:Number;
        
        public function ScaleWarning()
        {
			trace("Box()");
        	super();
        }
		
		public function setLabel(warning:String):void
		{
			_warning_str = warning;
			_label.text = _warning_str;
		}
		
		public function setSize(width:Number, height:Number):void
		{
			_width = width;
			_height = height;
			_bk.width = _width;
			_bk.height = _height;
			_label.y = _height/2 - 20;
			_label.x = _width/2 - ( _label.width / 2);
			
		}

	
	}

}

