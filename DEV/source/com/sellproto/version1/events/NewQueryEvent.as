
package com.sellproto.version1.events
{
	
	import flash.events.*;

	public class NewQueryEvent extends Event 
	{
		
		public var evtObj:Object;
		
		public function NewQueryEvent(event:String, _evtObj:Object)
		{
			super(event, true, true);
			evtObj = _evtObj;
		//trace("NEW QUERY EVENT IS BEING DISPATCHED: " + evtObj);
		}
	}
}
