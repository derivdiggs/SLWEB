package com.sellproto.version1.view
{

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;

	public class DebugWindow extends MovieClip
	{

        
        public function DebugWindow()
        {
			trace("DebugWindow()");
        	super();
        }
		
		//display text in the debug window
		public function dTrace(newString:String):void
		{
			_dt.text = _dt.text + "\r" + newString;
			
		}
	
	}

}

