
package com.ddiggs.transitions.events
{
	
	import flash.events.*;

	public class CustomEvent extends Event 
	{
		
		public var evtObj:Object;
		
		public function CustomEvent(event:String, _evtObj:Object)
		{
			super(event, true, true);
			evtObj = _evtObj;
		//trace("CUSTOM EVENT IS BEING DISPATCHED: " + evtObj);
		}
	}
}
