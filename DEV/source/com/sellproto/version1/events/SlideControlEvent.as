package com.sellproto.version1.events
{

	import flash.events.Event;

	public class SlideControlEvent extends Event
	{
	
		public static const CHANGENUMBER:String = "changenumber";
		public var currentNumber:Number;
	
	
		public function SlideControlEvent(type:String, currentNumber:Number)
		{
			super(type, true, true);
			this.currentNumber = currentNumber;
		}
	
	}

}

