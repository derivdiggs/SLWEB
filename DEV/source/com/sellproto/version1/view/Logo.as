package com.sellproto.version1.view
{

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;

	public class Logo extends MovieClip
	{
		private var _size:Number;
		private var _id:int;
        
        public function Logo()
        {
			trace("Logo()");
        	super();
        }

		public function setBox(size:Number, id:int):void
		{
			_size = size;
			_id = id;
		
		}
	
	}

}

