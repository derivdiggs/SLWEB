
package com.sellproto.version1.events
{
	
	import flash.events.*;

	public class TryUploadEvent extends Event 
	{
		
		public var evtObj:Object;
		public static const TRYUPLOAD:String = "tryupload";
		public static const CANCELUPLOAD:String = "cancelupload";
		public static const UPLOADCOMPLETE:String = "uploadComplete";
		public static const PASSDATA:String = "passdata";
		
		
		public function TryUploadEvent(event:String, _evtObj:Object){
			super(event, true, true);
			this.evtObj = _evtObj;
	
		}
	}
}
