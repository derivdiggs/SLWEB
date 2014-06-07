package com.sellproto.version1.view
{

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import gs.*;
	import gs.easing.*;
	import com.sellproto.version1.datastorage.*;
	import com.sellproto.version1.events.*;
	import flash.net.URLRequest;
	import flash.net.sendToURL;
	import flash.net.URLVariables;
	import com.sellproto.version1.view.LoadingDD;

	public class ProfilePicHolder extends MovieClip
	{
		private var _size:Number;
		private var _oSet:Number;
		private var _oScale:Number = 1.05;
		private var _id:int;
		private var _x:Number;
		private var _y:Number;
		private var _oX:Number;
		private var _oY:Number;
		private var _media:MediaObject;
		private var _imgPath:String;
		private var _userPath:String;
		private var _serverPath:String;
		private var _image:Bitmap;
		private var _LoadingDD:LoadingDD;
		private var _profilePath:String;
		
        
        public function ProfilePicHolder()
        {
			//trace("ProfilePicHolder()");
        	super();
        }
		
	
		
		public function render(spath:String, upath:String, profilePath:String, size:Number):void
		{
			trace(" new spath: "+ spath+" prof: "+profilePath);
			_size = size;
			_userPath = upath;
			_serverPath = spath;
			_profilePath = profilePath;
			
			var tmp:String = _profilePath;
			
			var url:String = _serverPath + "thumbs/" + _profilePath;

			//var url:String = _serverPath + _userPath + "showthumb.php?src=" + tmp + "&x=" + _size + "&y=" + _size + "&f=0";
			
			loadImage(url);
		}
		
	
		private function loadImage(imagePath:String):void
		{
		
			_imgPath = imagePath;
			var _loaders:Loader = new Loader();
			var tmpURL:String = _imgPath;
			_loaders.load(new URLRequest(tmpURL));
			_loaders.contentLoaderInfo.addEventListener(Event.COMPLETE, handleImageLoadComplete);
			_loaders.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			//_loaders.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler)
		}
		
		private function handleImageLoadComplete(e:Event):void
		{
			var tmp_img:Bitmap =  Bitmap(e.target.content);
			var tmp_data:BitmapData = BitmapData(tmp_img.bitmapData);
			
			_image = tmp_img;
			//trace("image width: " + _image.width);
			
			if(_image.width > _image.height)
			{
				var ratio:Number = _size / _image.width;
				_image.width = _size;
				_image.height *= ratio;
			}
			else
			{
				var ratio:Number = _size / _image.height;
				_image.height = _size;
				_image.width *= ratio;
			}
			
			_image.x = 140;
			_image.y = 4;
			
			
			_image.alpha=0;
			addChild(_image);
			TweenMax.to(_image, .5, {alpha:1});
			trace("XXXXXXXXXXXXXXXXXXXXXPROFILEPICDONE");
			
		}
		
		private function progressHandler(event:ProgressEvent):void 
		{
			//var file:FileReference = FileReference(event.target);
			//trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void 
		{
	            trace("* ioErrorHandler: " + event.text);
		}
	
	}

}

