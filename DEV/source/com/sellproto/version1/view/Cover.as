package com.sellproto.version1.view
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;


	public class Cover extends Sprite
	{
		private var _width;
		private var _height;
        
        public function Cover()
        {
			trace("Cover()");
			//addEventListener(MouseEvent.CLICK, click_handler);
			//buttonMode = true;
			//mouseEnabled = false;
			//this.useHandCursor = false;
        	super();
        }
		
		public function setCover(wid:Number, high:Number):void
		{
			_width = wid;
			_height = high;
			_bk.width = _width;
			_bk.height = _height;
		
		
		}
		
		
	}
}

