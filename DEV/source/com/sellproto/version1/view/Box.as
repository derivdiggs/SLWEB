package com.sellproto.version1.view
{

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import gs.*;
	import gs.easing.*;
	import com.sellproto.version1.datastorage.*;
	import com.sellproto.version1.events.*;
	import flash.net.URLRequest;
	import flash.net.sendToURL;
	import flash.net.URLVariables;
	import com.sellproto.version1.view.LoadingDD;

	public class Box extends MovieClip
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
		private var _evtObj:Object; //required for button dispatch
		private var _holder:Sprite = new Sprite();
		
        
        public function Box()
        {
			//trace("Box()");
        	super();
        }
		
		public function setPaths(spath:String, upath:String):void
		{
			_userPath = upath;
			_serverPath = spath;
		    trace("BOX _userPath: " + _userPath + " _serverPath: " + _serverPath);
		}
		
		public function render(media:MediaObject):void
		{
			
			_media = media;
					
			var tmp:String = _media.getThumbPath();
			var tmp2:String = _media.getUPath();
		
			var url:String = "thumbs/" + tmp;
			
			//var url:String = tmp2 + "images/" + tmp;
			
			loadImage(url);
		}
		
		public function setBox(size:Number, id:int, boo:Boolean, xo:Number, yo:Number):void
		{
			if(boo)
			{
				addEventListener(MouseEvent.CLICK, click_handler);
				addEventListener(MouseEvent.MOUSE_OVER, over_handler);
				addEventListener(MouseEvent.MOUSE_OUT, out_handler);
				buttonMode = true;
				mouseEnabled = true;
				useHandCursor = true;
			}
			else
			{
				this.alpha=.5;
			}
			
			_x = xo;
			_y = yo;
			
			_size = size;
			_oSet = ((_size * _oScale) - _size) / 2;
			_oX = _x - _oSet;
			_oY = _y - _oSet;
			_id = id;
			_bk.width = _size;
			_bk.height = _size;
			_shadow.width = _size;
			_shadow.height = _size;
			//_label1.text = _id.toString();
			//trace("THIS X:" + this.x);
		}
		private function loadImage(imagePath:String):void
		{	
			Security.loadPolicyFile("http://www.thoughtrender.com/SLWEB/crossdomain.xml");
			//Security.loadPolicyFile("http://www.thoughtrender.com/SLWEB/users/de/derev_diggs/images/crossdomain.xml"); 
 
			_LoadingDD = new LoadingDD();
			_LoadingDD.x = _size/2;
			_LoadingDD.y = _size/2;
			_LoadingDD.alpha = .7;
			_LoadingDD._grad.visible = false;
			addChild(_LoadingDD);
			_imgPath = imagePath;
			var _loaders:Loader = new Loader();
			var context:LoaderContext;
			var tmpURL:String = _imgPath;
			context = new LoaderContext();
			context.checkPolicyFile = true;
			_loaders.load(new URLRequest(tmpURL),context);
			_loaders.contentLoaderInfo.addEventListener(Event.COMPLETE, handleImageLoadComplete);
			_loaders.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			//_loaders.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler)
		}
		
			private function handleImageLoadComplete(e:Event):void
			{
				var tmp_img:Bitmap =  Bitmap(e.target.content);
				var tmp_data:BitmapData = BitmapData(tmp_img.bitmapData);
				//addChild(_holder);
				//_holder.addChild(_image);
				//addChild(e.target.content);
				_image = tmp_img;
				//trace("image width: " + _image.width);
				
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
				_image.y = -_image.height/2;
				
				_holder.x =((_size - _image.width)/2) + _image.width/2;
				_holder.y = ((_size - _image.height)/2) + _image.height/2;
				
				_holder.rotation = _media.getRotation();
				
				if(_media.getRotation() == 90 || _media.getRotation() == 270)
				{
					_bk.width = _image.height+4;
					_bk.height = _image.width+4;
					_bk.x = (_holder.x-2) - _image.height/2;
					_bk.y = (_holder.y-2) - _image.width/2;

					_shadow.width = _bk.width;
					_shadow.height = _bk.height;
					_shadow.x = _bk.x;
					_shadow.y = _bk.y;
					
				}
				else
				{
					_bk.width = _image.width+4;
					_bk.height = _image.height+4;
					_bk.x = (_holder.x-2) - _image.width/2;
					_bk.y = (_holder.y-2) - _image.height/2;

					_shadow.width = _bk.width;
					_shadow.height = _bk.height;
					_shadow.x = _bk.x;
					_shadow.y = _bk.y;
				}
				

				_image.alpha=0;
				addChild(_holder);
				_holder.addChild(_image);
				TweenMax.to(_image, .5, {alpha:1});
				removeChild(_LoadingDD);
				_LoadingDD = null;
				
				
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
		
		private function over_handler(event:MouseEvent):void
		{
			parent.addChild(this);
			TweenMax.to(this, .3, {glowFilter:{color:0x8989F5, alpha:1, blurX:20, blurY:20}});
			TweenMax.to(this, .3, {x:_oX, y:_oY, scaleY:_oScale, scaleX:_oScale, ease:Quad.easeOut});
			if(_media.getRotation() == 90 || _media.getRotation() == 270)
			{
				TweenMax.to(_shadow, .5, {x:(_holder.x) - _image.height/2, y:(_holder.y) - _image.width/2, alpha:.5, width:_image.height+4, height:_image.width+4, ease:Quad.easeOut});
				
			}
			else
			{
				TweenMax.to(_shadow, .5, {x:(_holder.x) - _image.width/2, y:(_holder.y) - _image.height/2, alpha:.5, width:_image.width+4, height:_image.height+4, ease:Quad.easeOut});
			}
		}
		
		private function out_handler(event:MouseEvent):void
		{
			TweenMax.to(this, .5, {glowFilter:{color:0x8989F5, alpha:0, blurX:0, blurY:0}});
			TweenMax.to(this, .5, {x:_x, y:_y, scaleY:1, scaleX:1, ease:Quad.easeIn});
			if(_media.getRotation() == 90 || _media.getRotation() == 270)
			{
				TweenMax.to(_shadow, .5, {x:(_holder.x-2) - _image.height/2, y:(_holder.y-2) - _image.width/2, alpha:.8, width:_image.height+4, height:_image.width+4, ease:Quad.easeIn});
				
			}
			else
			{
				TweenMax.to(_shadow, .5, {x:(_holder.x-2) - _image.width/2, y:(_holder.y-2) - _image.height/2, alpha:.8, width:_image.width+4, height:_image.height+4, ease:Quad.easeIn});
				
			}
			
			
		}
		
		private function click_handler(event:MouseEvent):void
		{
			trace("BOX hit id: " + _id);
			dispatchEvent(new NavEvent(NavEvent.BOXNAV, _id, _evtObj));
		}
	
	}

}

