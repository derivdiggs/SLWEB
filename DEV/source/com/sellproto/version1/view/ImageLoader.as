/* ImageLoader.as
// This is used to load a recently uploaded image to the server. It also creates a thumbnail of the image for quicker preview.
// It uses the timer on CustomSprite.
*/

package com.sellproto.version1.view
{
	import com.adobe.images.JPGEncoder;
	import com.baseclasses.utils.Base64;
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.sendToURL;
	import flash.net.URLVariables;
	import com.adobe.images.JPGEncoder;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequestMethod;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import com.sellproto.version1.events.TryUploadEvent;
	import gs.*;
	import gs.easing.*;

	public class ImageLoader extends CustomSprite
	{
		private var _size:Number;
		private var _id:int;
		private var _imgPaths:Array = new Array();
		private var _loadedImageCnt:int = 0;
		private var _allImages:Array = new Array();
		private var _thumbImages:Array = new Array();
		private var _shouldTry:Boolean=true;
		private var _LoadingDD:LoadingDD = new LoadingDD();
		private var _userPath:String;
		private var _serverPath:String;
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var _isLoading:Boolean = false;
		private var _isImageOnScreen:Boolean = false;
		private var _imageDimms:String; // will be length by height i.e.800x600
		private var _holder:Sprite = new Sprite();
        
        public function ImageLoader()
        {
			trace("ImageLoader()");
        	super();
        }

		public function setStage(width:Number, height:Number):void
		{
			_stageWidth = width;
			_stageHeight = height;
			if(_isImageOnScreen)
			{
				//_allImages[0].x = (_stageWidth - _allImages[0].width) / 2;
				_holder.x= _stageWidth / 2;
			}
			trace(">>>>>>>> imageloader _stageWidth: " +_stageWidth);
			
		}

		public function loadImages(imagePaths:Array):void
		{
			_imgPaths = imagePaths;
			trace("imagePaths: " + _imgPaths);
			
			for(var i:int=0;i<_imgPaths.length;i++)
			{
				var _loaders:Loader = new Loader();
				var tmpURL:String = "http://thoughtrender.com/SLWEB/images/"+_imgPaths[i];
				//var tmpURL:String = _userPath + "images/"+_imgPaths[i];
				_loaders.load(new URLRequest(tmpURL));
				_loaders.name = String(i);
				_loaders.contentLoaderInfo.addEventListener(Event.COMPLETE, handleImageLoadComplete);
				_loaders.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			}
			/*
			initTimer: first number is how much time to do funct1, second number is how many times to do funct1 before funct2
			initTimer(milliseconds, milliseconds, autostart, funct1, funct2)
			*/
			initTimer(10000, 5, true, timeOut, retryLoad);
			
			//add loading animation to stage
			//var _LoadingDD:LoadingDD = new LoadingDD();
			_LoadingDD.scaleX=1.5;
			_LoadingDD.scaleY=1.5;
			_isLoading = true;
			addChild(_LoadingDD);
			_LoadingDD.x = (_stageWidth - _LoadingDD.width) / 2;
			_LoadingDD.y = 150;
		}
		
		public function setPaths(spath:String, upath:String):void
		{
			_userPath = upath;
			_serverPath = spath;
		}
		
		public function rotateImage(degrees:Number):void
		{
			//_allImages[0].rotation += degrees;
			
			TweenMax.to(_holder, 1, {rotation:(_holder.rotation + degrees), ease:Quint.easeOut});			
		}
		
		private function retryLoad():void
		{
			trace("retry load");
			
			if (_shouldTry)
			{
				loadImages(_imgPaths);
			}
		}
		
		private function timeOut():void
		{
			trace("timeOut");
			_shouldTry = false;
			killTimer();
		}
		//adds bitmap images to an array
		protected function handleImageLoadComplete(e:Event):void
		{
			//makeThumb();
			var tmp_img:Bitmap =  Bitmap(e.target.content);
			
			var tmp_data:BitmapData = BitmapData(tmp_img.bitmapData);
			
			//match the name of the file with the right position in array
			for(var t:int = 0; t < _imgPaths.length; t++)
			{   
			    if(e.target.loader.name == t)
				{ 
					trace(e.target.loader.name + " <<imgs>> : " + e.target.content + "position: "+ t);
					
					_allImages[t] = e.target.content;
					
					_imageDimms = e.target.content.width + "x" +e.target.content.height;
			     }
			}
				
			_loadedImageCnt++;
			
			if(_loadedImageCnt == _imgPaths.length)
			{
				killTimer();
				trace("finished loading image array");
				_shouldTry = false;
				resizeImage();
			}
		}
		
		private function duplicateImage(original:Bitmap):Bitmap {
            var image:Bitmap = new Bitmap(original.bitmapData.clone());
            return image;
        }
        
		private function resizeImage():void
		{
			_isImageOnScreen = true;
			var newHeight:Number = (200 / _allImages[0].width) * _allImages[0].height;
			_allImages[0].height = newHeight
			_allImages[0].width = 200;
			
			addChild(_holder);
			_holder.addChild(_allImages[0]);
			
			_holder.x= _stageWidth / 2;
			_holder.y= (_allImages[0].height / 2) + 20;
			_allImages[0].x = -_allImages[0].width / 2;
			_allImages[0].y = -_allImages[0].height / 2;
			
			
			
			if(_isLoading)
			{
				removeChild(_LoadingDD);
				_isLoading = false;
				
			}
			

			//dispatch that image has been uploaded
			dispatchEvent(new TryUploadEvent(TryUploadEvent.UPLOADCOMPLETE, {dimms : _imageDimms}));
			makeThumb();
		}
	
		private function ioErrorHandler(event:IOErrorEvent):void 
		{
	            trace("* ioErrorHandler: " + event.text);
		}
		
		private function makeThumb():void
		{
	
			var byteArray:ByteArray = getImageByteArray();			
			
			// send the variables to the PHP script
			var urlRequest:URLRequest = new URLRequest("thumbs/savethumb.php");

			urlRequest.method = URLRequestMethod.POST;			
			
			var variables:URLVariables = new URLVariables();
			variables.img = Base64.encode(byteArray); // the encoded ByteArray
			//variables.filename = "image-" + new Date().getTime() + ".jpg"; // the name of the image
			variables.filename = _imgPaths[0];
			urlRequest.data = variables;			
			
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, loadComplete);			
			loader.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			
			loader.load(urlRequest);
	
		}
		
		private function getImageByteArray():ByteArray
		{
			trace("getImageByteArray()");
			// get the BitmapData from image_mc
			var image_mc:MovieClip = new MovieClip();
			_thumbImages[0] = duplicateImage(_allImages[0]);
			image_mc.addChild(_thumbImages[0]);
			_thumbImages[0].x = 0;
			_thumbImages[0].y = 0;
			//_thumbImages[0].x = _thumbImages[0].width / 2;
			//_thumbImages[0].y = _thumbImages[0].height / 2;
			
			//trace("image_mc: "+image_mc);
			var bmd:BitmapData = new BitmapData (image_mc.width, image_mc.height);
			bmd.draw(image_mc);

			// convert to ByteArray
			var jpg:JPGEncoder = new JPGEncoder(85); // compression set to 85		
			//var tmp_data:BitmapData = BitmapData(_allImages[0].bitmapData);
			//var byteArray:ByteArray = tmp_data.getPixels();
			var byteArray:ByteArray = jpg.encode(bmd);
			
			return byteArray;			
		}
		
		/*
		private function getImageByteArray():ByteArray
		{
			trace("getImageByteArray()");
			// get the BitmapData from image_mc
			var image_mc:MovieClip = new MovieClip();
			//_thumbImages[0] = _allImages[0];
			_thumbImages[t] = duplicateImage(_allImages[t]);
			var duplicate:Bitmap = duplicateImage(image);
			trace("_allImages[0]: "+ _allImages[0] + "_thumbImages[0]: " + _thumbImages[0]);
			
			image_mc.addChild(_thumbImages[0]);
			_thumbImages[0].x = _thumbImages[0].width / 2;
			_thumbImages[0].y = _thumbImages[0].height / 2;
			
			//trace("image_mc: "+image_mc);
			var bmd:BitmapData = new BitmapData (image_mc.width, image_mc.height);
			bmd.draw(image_mc);

			// convert to ByteArray
			var jpg:JPGEncoder = new JPGEncoder(85); // compression set to 85		
			//var tmp_data:BitmapData = BitmapData(_allImages[0].bitmapData);
			//var byteArray:ByteArray = tmp_data.getPixels();
			var byteArray:ByteArray = jpg.encode(bmd);
			
			return byteArray;			
		}
		*/
		private function loadComplete(e:Event):void 
		{	
			var loader:URLLoader = URLLoader(e.currentTarget);
			//status_txt.text = loader.data;
		}
		
		private function loadError(e:IOErrorEvent):void 
		{
			//status_txt.text = "Error saving image.";
		}
	
	}

}

