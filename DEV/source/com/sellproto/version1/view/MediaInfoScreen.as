package com.sellproto.version1.view
{

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import gs.*;
	import gs.easing.*;
	import com.sellproto.version1.view.*;
	import com.sellproto.version1.events.*;
	import flash.net.URLRequest;
	import flash.net.sendToURL;
	import flash.net.URLVariables;
	import com.sellproto.version1.datastorage.*;

	public class MediaInfoScreen extends MovieClip
	{
		private var _media:MediaObject;
		private var _imgPath:String;
		private var _userPath:String;
		private var _serverPath:String;
		private var _image:Bitmap;
		private var _LoadingDD:LoadingDD;
		private var _profilePath:String;
		private var _size:Number;
		private var _isFirst:Boolean; //is true after author thumb done
		private var _imagesOnScreen_ar:Array = new Array();
		private var _imgCnt:int=0;
		private var _evtObj:Object;
        
        public function MediaInfoScreen()
        {
			trace("MediaInfoScreen()");
        	super();
			_close_but
			_close_but.addEventListener(MouseEvent.CLICK, _closeClick_handler);
			_close_but.addEventListener(MouseEvent.MOUSE_OVER, _closeOver_handler);
			_close_but.addEventListener(MouseEvent.MOUSE_OUT, _closeOut_handler);
			_close_but.buttonMode = true;
			_close_but.mouseEnabled = true;
			_close_but.useHandCursor = true;
        }
		
		public function setLabels(media:MediaObject, serverPath:String):void
		{
			if(_imagesOnScreen_ar.length > 0)
			{
				for(var t:int=0 ; t< _imagesOnScreen_ar.length ; t++)
				{
					removeChild(_imagesOnScreen_ar[t]);
					_imagesOnScreen_ar[t] = null;
				}
			}
			_imagesOnScreen_ar = [];
			_isFirst=true;
			_media = media;
			_name_dt.text = _media.getMediaPath();
			_author_dt.text = _media.getAuthor();
			_tags_dt.text = _media.getTags();
			_fromAlbum_dt.text = _media.getFromAlbum();
			_price_dt.text = _media.getPrice() + " ($US)";
			_dimms_dt.text = _media.getQuality();
			_size_dt.text = _media.getSize() +"k";
			_date_dt.text = _media.getUpDate();
			_serverPath = serverPath;
			render(_media.getUPath(), _media.getAuthorPath());
		}
		
		public function render(upath:String, imagePath:String):void
		{
			_size = 50;
			_userPath = upath;
			
			
			//var tmpPath:String = _serverPath + _userPath + "images/" + _profilePath;
			var tmp:String = imagePath;
			//var url:String = _serverPath + _userPath + "showthumb.php?src=" + tmp + "&x=" + _size + "&y=" + _size + "&f=0";
			var tmp2:String = _userPath;
			var url:String = tmp2 + "dshowthumb.php?src=" + tmp + "&ipath=images/&x=" + _size + "&y=" + _size + "&f=0";
			
			//trace("LOAD IMAGE URL: " + url);
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
			/*
			if(_image != null)
			{
				removeChild(_image);
				_image = null;
			}
			*/
			_image = tmp_img;
			//trace("image width: " + _image.width);
			if(_isFirst)
			{

				_image.x =7;
				_image.y = 44;
				_isFirst=false;
				render(_media.getUPath(), _media.getAlbumPath());
			}
			else
			{
				_image.x =7;
				_image.y = 130;
				
			}
			
			_image.alpha=0;
			addChild(_image);
			
			_imagesOnScreen_ar.push(_image);
			
			TweenMax.to(_image, .5, {alpha:1});
			
	
			
			//trace("XXXXXXXXXXXXXXXXXXXXXPROFILEPICDONE");
			
		}
		
		private function _closeOver_handler(event:MouseEvent):void
		{
			TweenMax.to(_close_but, .2, {glowFilter:{color:0x8989F5, alpha:1, blurX:10, blurY:10}});
		}

		private function _closeOut_handler(event:MouseEvent):void
		{
			TweenMax.to(_close_but, .4, {glowFilter:{color:0x8989F5, alpha:0, blurX:0, blurY:0}});
		}

		private function _closeClick_handler(event:MouseEvent):void
		{
			trace("next hit")
			dispatchEvent(new NavEvent(NavEvent.BASICBUT, 12, _evtObj));
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

