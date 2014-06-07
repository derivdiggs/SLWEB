package com.sellproto.version1.events
{

	import flash.events.Event;

	public class ReSizeEvent extends Event
	{
	
		public static const CHANGECONTSIZE:String = "changecontsize";
		public static const UPDATESIZE:String = "updatesize";
		public var currentNumber:Number;
		public var evtObj:Object;
	
	
		public function ReSizeEvent(type:String, evtObj:Object)
		{
			super(type, true, true);
			this.evtObj = evtObj;
		}
	
	}

}

