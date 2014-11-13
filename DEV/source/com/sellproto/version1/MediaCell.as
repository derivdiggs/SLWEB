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
		trace("MediaCell v7.6");
		public static const BASE_URL:String = "http://thoughtrender.com/SLWEB/";
		private var _ViewController:ViewController; //main viewcontroller
		private var _XMLProfileManager:XMLProfileManager; // load and parse user profile XML
		private var _XMLQueryManager:XMLQueryManager; // parse database querys
		private var _XMLAuthorQueryManager:XMLQueryManager; // parse all users xml
		private var _debug:DebugWindow; // a simple window for tracing variables live
		
		private var _serverPath:String; // path to the server .SWF resides
		private var _userPath:String = "users/de/derev_diggs/"; // used for local development
		private var _xmlPath:String="xml/userprofile.xml"; // used for local development
		
		//set temporarily to true to test upload feature
		//private var _isLoggedIn:Boolean=true;
		private var _isLoggedIn:Boolean=false;
		
		private var _stageAlbum:AlbumObject; // holder for media items that will appear on the stage
		private var _userAlbum:AlbumObject; // holder for a users media items
		private var _SettingsObject:SettingsObject; // holds user settings for application
		private var _userName:String="guest";
		private var _pageURL:String;
		private var _currentQuery:String = "";
		
		public static var docRoot:Object;
		public static var docStage:DisplayObject;
        
		/*
		*** Grabs environmental variables 
		*/
			
        public function MediaCell()
        {
			trace("SellMedia()");
			
			var now:Date = new Date(); // grab current date and time
			Security.allowDomain("*"); // allow calls to scripts within domain
			
			docRoot = this;
			docStage = this.stage;
        	super();
			//get the URL of the swf file
			_pageURL = ExternalInterface.call('window.location.href.toString');
			//checks to see if page is at http://thoughtrender.com/SLWEB/ or http://wwww.thoughtrender.com/SLWEB/
			// resolves to http://thoughtrender.com/SLWEB/ it it's not here already (for security reasons)
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
			checkLogin();
			
		}
		
		
		/*
		*** if user is logged in load their profile otherwise load a guest profile
		*/
			
		private function checkLogin():void
		{
			
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
		
		private function loadProfile():void
		{
			trace("loadProfile()")
			var fullXMLpath:String = _serverPath + "getprefs2.php?user="+ _userName; // create path to user xml
		
			_XMLProfileManager = new XMLProfileManager();
		   	_XMLProfileManager.init(fullXMLpath);
		   	_XMLProfileManager.addEventListener("dataArrayLoaded", profileDataComplete);
		}
		/*
		*** change users and load the new user's prefs
		*/
			
		private function changeUserPrefs(e:ChangeUserEvent):void
		{
			trace(">>CHANGEUSERPREFS()>>" + e.userName)
			_userName = e.userName;
			//create a debug window for me
			if(_userName == "deriv")
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
			imageQuery("initial", "null");
			_ViewController.setPaths(_serverPath, _userPath);
		}
		
		protected function newProfileDataComplete(e:CustomEvent):void
		{
			trace("** RELOADED USER DATA LOAD COMPLETE ** USER DATA LOAD COMPLETE ** USER DATA LOAD COMPLETE **: "+_XMLProfileManager.mySettings);
			_SettingsObject = _XMLProfileManager.mySettings;
			_userPath = _SettingsObject.getShortPath();
			
			_ViewController.passSettings(_SettingsObject);
			_ViewController.setPaths(_serverPath, _userPath);
			imageQuery("author", "null");
		}	
	}
}

