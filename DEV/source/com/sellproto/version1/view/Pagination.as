package com.sellproto.version1.view
{

import flash.display.*;
import flash.utils.*;
import flash.events.*;
import gs.*;
import gs.easing.*;

	public class Pagination extends MovieClip
	{
		private var _pagination_str:String;
        
        public function Pagination()
        {
			trace("Box()");
        	super();
        }
		
		public function setLabel(pagination_str:String):void
		{
			_pagination_str = pagination_str;
			_label.text = _pagination_str;
		}
		

	
	}

}

