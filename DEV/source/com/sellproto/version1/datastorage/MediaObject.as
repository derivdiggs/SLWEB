/*
*  MEDIA OBJECT
* - organizes the data of an xml _node
* 
*/

package com.sellproto.version1.datastorage
{

	import flash.display.*;

	public class MediaObject extends Object
	{
		private var _node:XML;
	
		public function MediaObject(nod:XML)
		{
			super();
			_node = nod;
			//trace(">>>media object _node: "+_node);
		}
		
		public function getID():Number
		{
			return _node.@id;
		}
		
		public function getName():String
		{
			return _node.@name;
		}
		
		public function getType():String
		{
			return _node.@type;
		}
		
		public function getAuthor():String
		{
			return _node.author;
		}
		
		public function getFromAlbum():String
		{
			return _node.fromalbum;
		}
		
		public function getServerPath():String
		{
			return _node.spath;
		}
		
		public function getUPath():String
		{
			return _node.upath;
		}
		
		public function getAuthorPath():String
		{
			return _node.authorpath;
		}
		
		public function getAlbumPath():String
		{
			return _node.albumpath;
		}
		
		public function getThumbPath():String
		{
		//	var folderName:String =  _node.Author.charAt(0) + _node.Author.charAt(1);
		//	trace(">>>>>>>>>>>>>>>>>>>>>> folderName: " + folderName);
			return _node.thumb;
		}
		
		public function getMediaPath():String
		{
		//	var folderName:String =  _node.Author.charAt(0) + _node.Author.charAt(1);
		//	trace(">>>>>>>>>>>>>>>>>>>>>> folderName: " + folderName);
			return _node.full;
		}
		
		public function getRotation():Number
		{
			return _node.rotation;	
		}
		
		public function getTags():String
		{
			return _node.tags;	
		}
		
		public function getPrice():String
		{
			return _node.price;	
		}
		
		public function getQuality():String
		{
			return _node.quality;	
		}
		
		public function getSize():String
		{
			return _node.size;	
		}
		
		public function getUpDate():String
		{
			return _node.date;	
		}
	}

}

