package com.sellproto.version1.events
{

	import flash.events.Event;

	public class CheckBoxEvent extends Event
	{
	
		public static const TOGGLE:String = "toggle";
		public var whichCheckBoxRow:String;
		public var whichButton:Number;
		public var isActive:Boolean
	
		public function CheckBoxEvent(type:String, whichCheckBoxRow:String, whichButton:Number, isActive:Boolean)
		{
			super(type, true, true);
			this.whichButton = whichButton;
			this.whichCheckBoxRow = whichCheckBoxRow;
			this.isActive = isActive;
		}
	
	}

}

