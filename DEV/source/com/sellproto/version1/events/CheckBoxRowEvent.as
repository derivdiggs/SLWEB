package com.sellproto.version1.events
{

	import flash.events.Event;

	public class CheckBoxRowEvent extends Event
	{
	
		public static const ROWDATA:String = "rowdata";
		public var whichCheckBoxRow:String;
		public var results_arr:Array;
	
		public function CheckBoxRowEvent(type:String, whichCheckBoxRow:String, results_arr:Array)
		{
			super(type, true, true);
			this.whichCheckBoxRow = whichCheckBoxRow;
			this.results_arr = results_arr;
		}
	
	}

}

