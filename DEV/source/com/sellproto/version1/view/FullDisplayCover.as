/*
*** FullDisplayCover is used to display full images and is sent data from the stage manager as to what image to display
*** 
***
*/

package com.sellproto.version1.view
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import com.sellproto.version1.view.*;
	import com.sellproto.version1.events.*;
	import com.sellproto.version1.datastorage.*;
	import flash.net.URLRequest;
	import flash.net.sendToURL;
	import flash.net.URLVariables;
	import gs.*;
	import gs.easing.*;


	public class FullDisplayCover extends CustomSprite
	{
		private var _media:MediaObject;
		private var _LoadingDD:LoadingDD;
		private var _size:Number = 400;
		private var _image:Bitmap;
		private var _holder:Sprite = new Sprite(); //container for _image
		private var _lastImage:Bitmap;
		private var _imgPath:String;
		private var _width;
		private var _height;
		private var _imageWidth;
		private var _imageHeight;
		private var _userPath:String;
		private var _serverPath:String;
		private var _stageAlbum:AlbumObject;
		private var _currentMediaNum:int;
		private var _SlideDisControl:SlideDisControl;
		private var _closeButton:CloseButtonIcon = new CloseButtonIcon;
		private var _media_arr:Array = new Array();
		private var _Pagination:Pagination = new Pagination();
		private var _isPlaying:Boolean = false;
		private var _MediaInfoScreen:MediaInfoScreen = new MediaInfoScreen();
		private var _isInfoUp:Boolean = true;
		private var _slideDelay:Number=3000; //delay of slide show in milliseconds
		private var _slideControlwidth:Number;
		
        
        public function FullDisplayCover()
        {
			trace("Cover()");
			//addEventListener(MouseEvent.CLICK, click_handler);
			/*
			buttonMode = true;
			mouseEnabled = false;
			this.useHandCursor = false;
			*/
        	super();
        }
		
		public function setCover(wid:Number, high:Number, stageAlbum:AlbumObject, userPath:String, serverPath:String, currentMediaNum:int):void
		{
			trace("setcover!")
			_width = wid;
			_height = high;
			_bk.width = _width;
			_bk.height = _height;
			_stageAlbum = stageAlbum;
			_userPath = userPath;
			_serverPath = serverPath;
			
			_currentMediaNum = currentMediaNum;
			
			var tmpMedia_arr:Array = _stageAlbum.getMediaArray();
			_media_arr = tmpMedia_arr;
			trace("tmpMedia_arr[_currentMediaNum]: " + tmpMedia_arr[_currentMediaNum]);
			render(_media_arr[_currentMediaNum]);
			
			_closeButton.setButton(5);
			_closeButton.scaleX = .5;
			_closeButton.scaleY = .5;
			_closeButton.x = _width - _closeButton.width - 10;
			_closeButton.y = 10;
			
			
			addChild(_closeButton);
			
			_Pagination.x= _width - _Pagination.width -10;
			_Pagination.y= _height - _Pagination.height-10;
			
			addChild(_Pagination);
			var page_str:String = (_currentMediaNum+1) +" / "+ (_media_arr.length);
			_Pagination.setLabel(page_str);
			_SlideDisControl = new SlideDisControl();
			_SlideDisControl.scaleX=.5;
			_SlideDisControl.scaleY=.5;
		
		
		}
		
		public function setSize(wid:Number, high:Number):void
		{
			_width = wid;
			_height = high;
			_bk.width = _width;
			_bk.height = _height;
			_closeButton.x = _width - _closeButton.width - 10;
			_closeButton.y = 10;
			_Pagination.x= _width - _Pagination.width -10;
			_Pagination.y= _height - _Pagination.height-10;
			_SlideDisControl.y = _height - _SlideDisControl.height-10;
			_SlideDisControl.x = (_width- _SlideDisControl.width)/2;
			
			removeChild(_image);
			_image = null;
			
			render(_media_arr[_currentMediaNum]);
		}
		public function render(media:MediaObject):void
		{
			_media = media;
			if(_media.getRotation() == 90 || _media.getRotation() == 270)
			{
				if(_width < _height)
				{
					_size = _height - 40;
				}
				else
				{
					_size = _width - 20;
				}
			}
			else
			{
				if(_width > _height)
				{
					_size = _height - 40;
				}
				else
				{
					_size = _width - 20;
				}
			}
			
			var tmp:String = _media.getMediaPath();
			var tmp2:String = _media.getUPath();
			
			var url:String = "images/" + tmp;
			
			//var url:String = tmp2 + "images/" + tmp;

		

			loadFullImage(url);
		}
		
		private function startSlideShow():void
		{
			trace("startSlideShow()")
			//initTimer(time:int, interval:uint, autoStart:Boolean, myFunction:Function, myOtherFunction)
			initTimer(_slideDelay, 100, true, slideShowTO, advanceSlide);
		}
		
		private function stopSlideShow():void
		{
			trace("startSlideShow()")
			//initTimer(time:int, interval:uint, autoStart:Boolean, myFunction:Function, myOtherFunction)
			killTimer();
		}
		
		
		
		private function advanceSlide():void
		{
			trace("advanceSlide()");
			if(_currentMediaNum < _media_arr.length-1)
			{
				_currentMediaNum++;
				render(_media_arr[_currentMediaNum]);
				_MediaInfoScreen.setLabels(_media_arr[_currentMediaNum], _serverPath);
				if(_isInfoUp)
				{
					addChild(_MediaInfoScreen);
				}
			}
		}
		
		private function slideShowTO():void
		{
			//
			trace("click");
		}
		
		private function loadFullImage(imagePath:String):void
		{
			if(!_isPlaying)
			{
			
				_LoadingDD = new LoadingDD();
				_LoadingDD.scaleX=1.5;
				_LoadingDD.scaleY=1.5;
				_LoadingDD.alpha = .9;
				_LoadingDD.x = _width/2;
				_LoadingDD.y = _height/2;
				addChild(_LoadingDD);
			}
			
			
			
			_imgPath = imagePath;
			var _loaders:Loader = new Loader();
			var context:LoaderContext;
			var tmpURL:String = _imgPath;
			context = new LoaderContext();
			context.checkPolicyFile = true;
			_loaders.load(new URLRequest(tmpURL));
			_loaders.contentLoaderInfo.addEventListener(Event.COMPLETE, handleImageLoadComplete);
			_loaders.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			//_loaders.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler)
			if(_isInfoUp)
			{
				showInfoScreen();
			}
		}
		
		private function clearImage():void
		{
			_holder.removeChild(_lastImage);
			_lastImage = null;
			trace("REMOVE");
		}
		
		private function handleImageLoadComplete(e:Event):void
		{
			var page_str:String = (_currentMediaNum+1) +" / "+ (_media_arr.length);
			_Pagination.setLabel(page_str);
			
			if(_image != null)
			{
				_lastImage = _image;
				TweenMax.to(_lastImage, .8, {alpha:0, onComplete:clearImage});
				
			}
			var tmp_img:Bitmap =  Bitmap(e.target.content);
			var tmp_data:BitmapData = BitmapData(tmp_img.bitmapData);
			_holder.rotation = 0;
			
			if(_media.getRotation() == 90 || _media.getRotation() == 270)
			{
				_holder.x = _width/2;
				_holder.y = _height/2-15;
	
				_image = tmp_img;
				
				/* fit image */
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
				
				_image.x = -_image.width/2;
				_image.y =-_image.height/2;
				_image.alpha=0;
				addChild(_holder);
				_holder.addChild(_image);
				
			}
			else
			{
				_holder.x = _width/2;
				_holder.y = _height/2-15;
	
				_image = tmp_img;
				
					/* fit image */
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
				
				_image.x = -_image.width/2;
				_image.y =-_image.height/2;
				_image.alpha=0;
				addChild(_holder);
				_holder.addChild(_image);
				

			}
			_holder.rotation = _media.getRotation();
			TweenMax.to(_image, .8, {alpha:1});
			removeChild(_LoadingDD);
		
			_SlideDisControl.y = _height - _SlideDisControl.height-10;
			_SlideDisControl.x = (_width- _SlideDisControl.width)/2;
			_SlideDisControl.addEventListener(NavEvent.BASICBUT, doNavHit);
			addChild(_SlideDisControl);
			addChild(_Pagination);
			addChild(_closeButton);
			_LoadingDD = null;
			////set info fields////
			_MediaInfoScreen.setLabels(_media, _serverPath);
			if(_isInfoUp)
			{
				addChild(_MediaInfoScreen);
			}

		}

		private function ioErrorHandler(event:IOErrorEvent):void 
		{
	            trace("* ioErrorHandler: " + event.text);
		}
		
		private function showInfoScreen():void
		{
			_isInfoUp = true;
			_MediaInfoScreen.x=10;
			_MediaInfoScreen.y=10;
			addChild(_MediaInfoScreen);
			_MediaInfoScreen.addEventListener(NavEvent.BASICBUT, doNavHit);
		}
		
		private function hideInfoScreen():void
		{
			_isInfoUp = false;
			removeChild(_MediaInfoScreen);
		}
		
		
		private function click_handler(event:MouseEvent):void
		{
			//trace("cover hit!!");
		}
		
		private function doNavHit(e:NavEvent):void
		{
			trace("dfulldisplaycover + e.from: " + e.whichButton);
			switch(e.whichButton)
			{
				case 6:
					if(_currentMediaNum < _media_arr.length-1)
					{
						_currentMediaNum++;
						render(_media_arr[_currentMediaNum]);
					}
					break;
					
				case 7:
					if(_currentMediaNum > 0)
					{
						_currentMediaNum--;
						render(_media_arr[_currentMediaNum]);
					}
					break;
					
				case 8:
					if(_currentMediaNum != 0)
					{
						_currentMediaNum = 0;
						render(_media_arr[_currentMediaNum]);
					}
					break;
					
				case 9:
					if(_currentMediaNum != _media_arr.length-1)
					{
						_currentMediaNum = _media_arr.length-1;
						render(_media_arr[_currentMediaNum]);
					}
					break;
					
				case 10:
					if(_isPlaying)
					{
						
						_SlideDisControl.showPlay();
						_isPlaying = false;
						stopSlideShow();
					}
					else
					{
						if(_currentMediaNum < _media_arr.length-1)
						{
							_currentMediaNum++;
							render(_media_arr[_currentMediaNum]);
						}
						_SlideDisControl.showPause();
						_isPlaying = true;
						startSlideShow();
					
					}
					break;
					
				case 11://info
					if(_isInfoUp)
					{
						hideInfoScreen();
					}
					else
					{
						showInfoScreen();
					}
					
					break;
					
				case 12://info
					
						hideInfoScreen();
					break;
			}
				
			}
			
	}
}

