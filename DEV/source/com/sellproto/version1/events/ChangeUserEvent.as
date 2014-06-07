//This event is dispatched from the ViewController to MediaCell (the document class) when the app needs to load new user preferences

package com.sellproto.version1.events
{
	
	import flash.events.*;

	public class ChangeUserEvent extends Event 
	{
		
		public static const CHANGEUSER:String = "changeuser";
		public var userName:String;
	
	
		public function ChangeUserEvent(type:String, userName:String)
		{
			super(type, true, true);
			this.userName = userName;
		}
	}
}
