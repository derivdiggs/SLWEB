/*
*  ALBUM OBJECT
* - organizes MediaObjects and bitmaps associated with a particular album
* - takes in mediaObjects
* 
*/

package com.sellproto.version1.datastorage
{

	import flash.display.*;
	import com.sellproto.version1.datastorage.*;

	public class UserAlbumObject extends Object
	{
	
		private var _media_arr:Array = new Array();
		private var _name:String;
		private var _imagePath:String;
	
		public function UserAlbumObject()
		{
			super();
		}
		
		public function setProperties(n:String, i:String):void
		{
			_name = n;
			_imagePath = i;
		}
		
		
		public function addMediaObjects(m:MediaObject):void
		{

			_media_arr.push(m);	
		}
		
		public function getName():String
		{
			return _name;
		}
		
		public function getImagePath():String
		{
			return _imagePath;
		}
		
		public function getMediaArray():Array
		{
			return _media_arr;
		}
	
		public function getTotalItems():uint
		{
			return _media_arr.length;
		}
		
	
		
	}
}

