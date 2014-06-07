package com.sellproto.version1.view
{

	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.errors.*;
	import flash.net.*;
	import gs.*;
	import gs.easing.*;
	import com.sellproto.version1.events.*;

	public class LogginScreen extends MovieClip
	{
		private var _pagination_str:String;
		private var _id:Number=9;
		private var _password:String;
		private var _userName:String;
		private var _evtObj:Object;        

        public function LogginScreen()
        {
			trace("LogginScreen()");
        	super();
			_login.addEventListener(MouseEvent.CLICK, click_handler);
			_login.addEventListener(MouseEvent.MOUSE_OVER, over_handler);
			_login.addEventListener(MouseEvent.MOUSE_OUT, out_handler);
			_login.buttonMode = true;
			_login.mouseEnabled = true;
			_login.useHandCursor = true;
			//_username_it.tabIndex(1);
			//_password_it.tabIndex(2);
			//_login.tabEnabled(true);
			//_login.tabIndex(3);
			
			TweenMax.to(this, .3, {glowFilter:{color:0x8989F5, alpha:1, blurX:20, blurY:20}});
        }
		
		public function getUserName():String
		{
			return _userName;
		}
		
		private function doLogin(l:String, p:String):void
		{
			trace("DOLOGIN() l: " + l+ " p: "+p);
			Security.loadPolicyFile("http://www.thoughtrender.com/SLWEB/crossdomain.xml");
			trace("step1");
			_userName = l;
           // var loader:Loader = new Loader();
            trace("step2");
           // configureListeners(loader);
            
            
            /*
            var context:LoaderContext;
            trace("step3");
            context = new LoaderContext();
            var tmpURL:String = "http://www.thoughtrender.com/SLWEB/loginquery.php?user="+l+"&pass="+p;
            trace("step4");
            context.checkPolicyFile = true;
            trace("step5");
            loader.load(new URLRequest(tmpURL),context);
            trace("step6");
            */
            
            
            /*
            var _loaders:Loader = new Loader();
			var context:LoaderContext;
			var tmpURL:String = _imgPath;
			context = new LoaderContext();
			context.checkPolicyFile = true;
			_loaders.load(new URLRequest(tmpURL),context);
            */
            //configureListeners(loader);
			
			
			var loader:URLLoader = new URLLoader();
			configureListeners(loader);
            var request:URLRequest = new URLRequest("http://thoughtrender.com/SLWEB/loginquery.php");
			var variables:URLVariables = new URLVariables();
			variables.sublogin = "1";
			variables.user = l;
			variables.pass = p;
			variables.remember="";
			request.data = variables;
            request.method = URLRequestMethod.POST;
            loader.load(request);
            
            //loader.load(request, context);
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
        	trace("checking login");
            var loader:URLLoader = URLLoader(event.target);
            trace("completeHandler: " + loader.data);
			if(loader.data == "pass")
			{
				_status_dt.text ="PASS";
				dispatchEvent(new NavEvent(NavEvent.BASICBUT, _id, _evtObj));
			}
			else
			{
				_status_dt.text ="FAIL";
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
		
		private function over_handler(event:MouseEvent):void
		{
			
			TweenMax.to(_login, .3, {glowFilter:{color:0x8989F5, alpha:1, blurX:10, blurY:10}});
		}
		
		private function out_handler(event:MouseEvent):void
		{
			TweenMax.to(_login, .5, {glowFilter:{color:0x8989F5, alpha:0, blurX:0, blurY:0}});
		}
		
		private function click_handler(event:MouseEvent):void
		{
			trace("BOX hit id: " + _id);
			doLogin(_username_it.text, _password_it.text);
			//dispatchEvent(new NavEvent(NavEvent.BASICBUT, _id));
			
		}
	
	}

}

