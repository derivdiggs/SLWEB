/*
*  ALBUM OBJECT
* - organizes MediaObjects and bitmaps associated with a particular album
* - takes in an XML node then creates individual media object
* 
*/

package com.sellproto.version1.datastorage
{

	import flash.display.*;
	import com.sellproto.version1.datastorage.*;

	public class AlbumObject extends Object
	{
	
		private var _media_arr:Array = new Array();
		private var _mainNode:XML;
	
		public function AlbumObject()
		{
			super();
			
		}
		
		public function addNode(nod:XML):void
		{
			_mainNode = null;
			_mainNode = nod;
			_createMediaObjects();
		}
		
		public function getName():String
		{
			return _mainNode.@name;
		}
		
		public function getAuthor():String
		{
			return _mainNode.@author;
		}
		
		public function getThumb():String
		{
			return _mainNode.@thumb;
		}
		
		public function getMediaArray():Array
		{
			return _media_arr;
		}
	
		public function getTotalItems():uint
		{
			return _media_arr.length;
		}
		
		private function _createMediaObjects():void
		{
			for each(var node:XML in _mainNode.media)
			{
				var m:MediaObject = new MediaObject(node);

				_media_arr.push(m);
			}	
		}
		
	}
}

