package com.sellproto.version1
{

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.system.Security;
	import flash.external.ExternalInterface;
	import com.sellproto.version1.view.*;
	import com.sellproto.version1.events.NewQueryEvent;
	import com.baseclasses.events.CustomEvent;
	import com.sellproto.version1.events.ChangeUserEvent;
	import com.sellproto.version1.datastorage.*;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import flash.net.*;
	

	public class MediaCell extends Sprite
	{
		public static const BASE_URL:String = "http://thoughtrender.com/SLWEB/";
		private var _ViewController:ViewController;
		private var _XMLProfileManager:XMLProfileManager;
		private var _XMLQueryManager:XMLQueryManager;
		private var _XMLAuthorQueryManager:XMLQueryManager;
		private var _debug:DebugWindow;
		
		private var _serverPath:String;
		private var _userPath:String = "users/de/derev_diggs/";
		private var _xmlPath:String="xml/userprofile.xml";
		
		//set temporarily to true to test upload feature
		//private var _isLoggedIn:Boolean=true;
		private var _isLoggedIn:Boolean=false;
		
		private var _stageAlbum:AlbumObject;
		private var _userAlbum:AlbumObject;
		private var _SettingsObject:SettingsObject;
		private var _userName:String="guest";
		private var _pageURL:String;
		private var _currentQuery:String = "";
		
		public static var docRoot:Object;
		public static var docStage:DisplayObject;
        
        public function MediaCell()
        {
			trace("SellMedia()");
			var now:Date = new Date();
			Security.allowDomain("*");
			trace(now);
			trace("offset: " + now.getTimezoneOffset() / 60);
			trace(now.toDateString());
			
			
			var pageURL:String=ExternalInterface.call('window.location.href.toString');
			trace("PAGE URL: " + pageURL);
			docRoot = this;
			docStage = this.stage;
			trace("DOC STAGE: " + docStage.stage.height);
        	super();
			//get the URL of the swf file
			_pageURL = ExternalInterface.call('window.location.href.toString');
			//check to see if .swf is local or what the server path is.
			if(_pageURL == null || _pageURL == BASE_URL)
			{
				_serverPath = BASE_URL;
				initAll();
			}
			else
			{
				var url:String = BASE_URL;
	            var request:URLRequest = new URLRequest(url);
	            try {            
	                navigateToURL(request,"_self");
	            }
	            catch (e:Error) {
	                // handle error here
	            }
			}
        }
		
		private function initAll():void
		{
			/*
			_ViewController =  new ViewController();
			
			addChild(_ViewController);
			_ViewController.initStageMNGR(docStage);
			_ViewController.addEventListener(ChangeUserEvent.CHANGEUSER, changeUserPrefs);
			_ViewController.addEventListener("newQuery", doQuery);
			*/
			checkLogin();
			
	
		}
		
		private function loadProfile():void
		{
			trace("loadProfile()")
			var fullXMLpath:String = _serverPath + "getprefs2.php?user="+ _userName;
		
			_XMLProfileManager = new XMLProfileManager();
		   	_XMLProfileManager.init(fullXMLpath);
		   	_XMLProfileManager.addEventListener("dataArrayLoaded", profileDataComplete);
		}
		
		private function changeUserPrefs(e:ChangeUserEvent):void
		{
			trace(">>CHANGEUSERPREFS()>>" + e.userName)
			_userName = e.userName;
			if(_userName == "derev")
			{
				_debug = new DebugWindow();
				addChild(_debug);
				_debug.dTrace("URL: " + _pageURL);
				
			}
			var fullXMLpath:String = _serverPath + "getprefs2.php?user="+ _userName;
			//var fullXMLpath:String = _serverPath + _userPath + _xmlPath;
			_XMLProfileManager = new XMLProfileManager();
		   	_XMLProfileManager.init(fullXMLpath);
		   	_XMLProfileManager.addEventListener("dataArrayLoaded", newProfileDataComplete);
		}
		
		private function imageQuery(type:String, value:String):void
		{
			switch(type)
			{
				case "initial":
					var fullXMLpath2:String = _serverPath + "query.php";
					_XMLQueryManager = new XMLQueryManager();
				   	_XMLQueryManager.init("initialLoad",fullXMLpath2);
				   	_XMLQueryManager.addEventListener("dataArrayLoaded", galleryDataComplete);
					break;
					
				case "author":
					var fullXMLpath2:String = _serverPath + "authorquery.php?author=" + _userName;
					_XMLQueryManager = new XMLQueryManager();
				   	_XMLQueryManager.init("authorquery",fullXMLpath2);
				   	_XMLQueryManager.addEventListener("dataArrayLoaded", galleryDataComplete);
					break;
			}
		}
	
		protected function queryComplete(e:CustomEvent):void
		{
			//
			trace("QUERRY DATA COMPLETE ***"+ e.evtObj.type);
			_stageAlbum = _XMLQueryManager.stageAlbum;
			_ViewController.setStageAlbum(_stageAlbum);
			
		}
	
		private function doQuery(e:NewQueryEvent):void
		{
			//trace("DO QUERY  TEMS: " + e.terms);
			var fullXMLpath2:String = _serverPath + "query.php";
			_XMLQueryManager = new XMLQueryManager();
		   	_XMLQueryManager.init("doquerry", fullXMLpath2);
		   	_XMLQueryManager.addEventListener("dataArrayLoaded", queryComplete);
		}
		
		private function checkLogin():void
		{
			trace("checkLogin()")
			trace("_isLoggedIn: " + _isLoggedIn)
			if(_isLoggedIn)
			{
				loadProfile();
				//commented out new
				_ViewController.changeLoginStatus(true);
			}
			else
			{
				_userPath = "users/gu/guest/";	
				loadProfile();
				
			}
		}
		
		//invoked after gallery XML data is finished loading
		protected function galleryDataComplete(e:CustomEvent):void
		{
			//
			trace("GALLERY DATA COMPLETE ***"+ e.evtObj.type);
			switch(e.evtObj.type)
			{
				case "initialLoad":
					_stageAlbum = _XMLQueryManager.stageAlbum;
					_ViewController.setStageAlbum(_stageAlbum);
					break;
					
				case "authorquery":
					_userAlbum = _XMLQueryManager.stageAlbum;
					_ViewController.setUserAlbum(_userAlbum);
					trace("\r!!!authorquery complete!!!\r");
					break;
			}
			
			
		}
		
		protected function authorAlbumDataComplete(e:CustomEvent):void
		{
			trace("author album data complete!!");
		}
		
		
		//invoked after profile XML data is finished loading
		protected function profileDataComplete(e:CustomEvent):void
		{
			trace("** USER DATA LOAD COMPLETE ** USER DATA LOAD COMPLETE ** USER DATA LOAD COMPLETE **: "+_XMLProfileManager.mySettings);
			_ViewController =  new ViewController();
			addChild(_ViewController);
			_ViewController.initStageMNGR(docStage);
			_ViewController.addEventListener(ChangeUserEvent.CHANGEUSER, changeUserPrefs);
			_ViewController.addEventListener("newQuery", doQuery);
			_ViewController.passSettings(_XMLProfileManager.mySettings);
			//initialImageLoad();
			imageQuery("initial", "null");
			_ViewController.setPaths(_serverPath, _userPath);
		}
		
		protected function newProfileDataComplete(e:CustomEvent):void
		{
			trace("** RELOADED USER DATA LOAD COMPLETE ** USER DATA LOAD COMPLETE ** USER DATA LOAD COMPLETE **: "+_XMLProfileManager.mySettings);
			_SettingsObject = _XMLProfileManager.mySettings;
			//_ViewController.passSettings(_XMLProfileManager.mySettings);
			//_ViewController.passSettings(_SettingsObject);
			_userPath = _SettingsObject.getShortPath();
			
			_ViewController.passSettings(_SettingsObject);
			_ViewController.setPaths(_serverPath, _userPath);
			//authorQuery();
			//initialImageLoad();
			imageQuery("author", "null");
		}	
	}
}

