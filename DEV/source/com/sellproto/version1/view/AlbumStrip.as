package com.sellproto.version1.view
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import com.baseclasses.geometricshapes.Rect;
	import com.sellproto.version1.datastorage.*;


	public class AlbumStrip extends Sprite
	{
		private var _width:Number;
		private var _height:Number;;
		private var _userAlbum:AlbumObject = new AlbumObject();
		private var _bkColor:Number;
		private var _borderColor:Number;
		private var _bWidth:Number;
		private var _userAlbumArray:Array = new Array(); // keeps an array of albums of the user
        
        public function AlbumStrip()
        {
			trace("AlbumStrip()");
        	super();
        }
		
		public function setStrip(album:AlbumObject, wid:Number, high:Number):void
		{
			_userAlbum = album;
			_width = wid;
			_height = high;
			//_bk.width = _width;
			//_bk.height = _height;
		}
		
		private function createAlbumSets():void
		{
			var albumNameArray:Array = new Array();
			var tempMediaArray:Array = _userAlbum.getMediaArray();
			for(var t:int=0 ; t < _userAlbum.getTotalItems() ; t++)
			{
				for(var i:int=0 ; i < albumNameArray.length ; i++)
				{
					if(tempMediaArray[t].getFromAlbum() == albumNameArray[i])
					{
						//_userAlbumArray.
						//last state I was at
					}
					else
					{
						var ua:UserAlbumObject = new(UserAlbumObject);
						ua.setProperties(tempMediaArray[t].getFromAlbum(),tempMediaArray[t].getAlbumPath);
						albumNameArray.push(tempMediaArray[t].getFromAlbum());
						_userAlbumArray.push(ua);
					}
				}
			}
		}
	}
}

