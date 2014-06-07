package com.sellproto.version1.events
{

	import flash.events.Event;

	public class NavEvent extends Event
	{
	
		public static const TOPNAV:String = "topnav";
		public static const BOXNAV:String = "boxnav";
		public static const BOTNAV:String = "botnav";
		public static const LEFTNAV:String = "leftnav";
		public static const BASICBUT:String = "basicbut";
		public static const SUBMITLOGIN:String = "submitlogin";
		public var whichButton:Number;
		public var evtObj:Object;
	
	
		public function NavEvent(type:String, whichButton:Number, _evtObj:Object)
		{
			super(type, true, true);
			this.whichButton = whichButton;
			evtObj = _evtObj;
		}
	
	}

}

