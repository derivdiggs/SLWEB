package com.sellproto.version1.view
{

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.errors.*;
	import flash.net.*;
	import com.sellproto.version1.events.*;

	public class AddNewMedia extends Sprite
	{
		
		private var _userName:String;
		public static const ADD_MEDIA_URL:String = "http://thoughtrender.com/SLWEB/addMedia.php"
        
        public function AddNewMedia()
        {
			trace("ADDNEWMEDIA()");
        	super();
			
        }
		
		public function addMedia(variables:URLVariables):void
		{
			//var variables:URLVariables = tmpObj
            var loader:URLLoader = new URLLoader();
            configureListeners(loader);

            var request:URLRequest = new URLRequest(ADD_MEDIA_URL);
			//var variables:URLVariables = new URLVariables();
			//variables.sublogin = "1";
			//variables.user = l;
			//variables.pass = p;
			//variables.remember="";
			request.data = variables;
            request.method = URLRequestMethod.POST;
            loader.load(request);
        }

        private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }

        private function completeHandler(event:Event):void {
            var loader:URLLoader = URLLoader(event.target);
            trace("completeHandler: " + loader.data);
			if(loader.data == "pass")
			{
				trace("PASS");
				//dispatchEvent(new NavEvent(NavEvent.BASICBUT, _id));
			}
			else
			{
				trace("FAIL");
			}
        }

        private function openHandler(event:Event):void {
            trace("openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
            trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }
		
	
	}

}

