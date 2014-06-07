/*
*  ALBUM OBJECT
* - organizes MediaObjects and bitmaps associated with a particular album
* 
*/

package com.sellproto.version1.datastorage
{

	import flash.display.*;
	import com.sellproto.version1.datastorage.*;

	public class SettingsObject extends Object
	{
	
		private var _media_arr:Array = new Array();
		private var _mainNode:XML;
		private var _username:String;
		private var _userID:String;
		private var _lasttab:String;
		private var _firstname:String;
		private var _lastname:String;
		private var _isGuest:Boolean = false;
	
		public function SettingsObject(nod:XML)
		{
			super();
			_mainNode = nod;
			trace("Settings got Node: " + _mainNode);
			if(nod==null)
			{
				trace("NULL settings node");
				_isGuest=true;
				//_mainNode.username = "Guest";
			}
		}
		
		public function getUserName():String
		{
			if(_isGuest)
			{
				return "guest";
			}
			else
			{
				return _mainNode.username;
			}
			
		}
		
		public function getUserID():String
		{
			return _mainNode.userID;
		}
		
		public function getLastTab():String
		{
			return _mainNode.lasttab;
		}
		
		public function getFirstName():String
		{
			return _mainNode.firstname;
		}
		
		public function getLastName():String
		{
			return _mainNode.lastname;
		}
		
		public function getShortPath():String
		{
			return _mainNode.shortupath;
		}
		
		public function getUserPath():String
		{
			return _mainNode.upath;
		}
		
		public function getProfilePic():String
		{
			if(_isGuest)
			{
				return "blue.jpg";
			}
			else
			{
				return _mainNode.profilepic;
			}
			
		}
		
	}
}

