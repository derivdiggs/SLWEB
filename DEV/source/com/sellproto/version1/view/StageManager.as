package com.sellproto.version1.view
{

	import flash.display.*;
	import flash.display.Stage;
	import flash.utils.*;
	import flash.events.*;
	import com.sellproto.version1.view.*;
	import com.sellproto.version1.events.*;
	import com.sellproto.version1.datastorage.*;
	import flash.net.URLRequest;
	import flash.net.sendToURL;
	import flash.net.URLVariables;
	import gs.*;
	import gs.easing.*;


	public class StageManager extends CustomSprite
	{
	
		public static var theDocStage:DisplayObject;
		public var searchTerm_str:String;
		
		private var _border:Sprite;
		private var _bk:Sprite;
		private var _topBar:Sprite;
		private var _botBar:Sprite;
		private var _TriangleLeft:Triangle = new Triangle();
		private var _TriangleRight:Triangle = new Triangle();
		private var _ScaleWarning:ScaleWarning = new ScaleWarning();
		private var _SearchField:SearchField = new SearchField();
		private var _Logo:Logo = new Logo();
		private var _Pagination:Pagination = new Pagination();
		private var _LeftNav:LeftNav = new LeftNav();
		private var _FullScreenBut:FullScreenBut = new FullScreenBut();
		private var _borderWidth:Number;
		private var _borderColor:Number;
		private var _bkColor:Number;
		private var _height:Number;
		private var _width:Number;
		private var _topBar_x:Number;
		private var _gLength:Number; //length of the grid
		private var _gHeight:Number; //height of the grid
		private var _gBoxSize:Number; //The size of a box in the grid
		private var _gSpace:Number; //The space between boxes
		private var _gRows:Number;
		private var _gCols:Number;
		private var _gX:Number;
		private var _gY:Number;
		private var _gDistance:Number;
		private var _leftButtonX:Number;
		private var _allBoxes_arr:Array = new Array;
		private var _topBar_height:Number = 50;
		private var _botBar_height:Number = 50;
		//public var boxNum:int = 80;
		public var boxNum:int;
		private var _boxesOnScreen:int = 0;
	    private var _currentPage:int = 1;
		private var _totalPages:int = 0;
		private var isScaleWarning:Boolean = false;
		private var _activeLeftNavBut:int = 1;
		public var cdcStartHeight:Number;
		public var _isFirstRun:Boolean = true;
		private var _stageAlbum:AlbumObject;
		private var _userPath:String;
		private var _serverPath:String;
		private var _hasAlbum = false;
		private var _FullDisplayCover:FullDisplayCover;
		private var _hasFullDisplayCover:Boolean = false;
		private var _media:MediaObject;
		private var _LoadingDD:LoadingDD;
		private var _size:Number = 400;
		private var _image:Bitmap;
		private var _imgPath:String;
		private var _closeButton:BasicButton = new BasicButton;
		private var _profilePicSize:int = 40;
		private var _ProfilePicHolder:ProfilePicHolder = new ProfilePicHolder;
		private var _isLoggedIn:Boolean = false;
	
    
        public function StageManager(stage:DisplayObject, bkColor:Number , borderColor:Number, borderWidth:Number, vertDivider_x:Number)
        {
			trace("StageManager()");
			//TweenPlugin.activate([GlowFilterPlugin]);
        	super();
			theDocStage = stage;
			_borderWidth = borderWidth;
			_borderColor = borderColor;
			_bkColor = bkColor;
			_height = theDocStage.stage.stageHeight;
			_width = theDocStage.stage.stageWidth;
			_topBar_x = vertDivider_x + borderWidth;
			_gX = vertDivider_x + 2 * borderWidth+10;
			_gY = 2 * borderWidth + _topBar_height+10;
			_gLength = (_width) - _gX;
			_gHeight = (_height) - _gY - _botBar_height;
			
			trace("StageManager - theDocStage: " + theDocStage);
			trace("StageManager - stageWidth: " + theDocStage.stage.stageWidth + " stageHeight: " + theDocStage.stage.stageHeight);
        	initTimer(100, 1, true, sendSize, sendSize);
			initAll();
        }
		
		public function setPaths(spath:String, upath:String):void
		{
			_userPath = upath;
			_serverPath = spath;
		}
		
		public function setUserName(userName:String):void
		{
			trace("set user name to " + userName);
			_Logo._userName_dt.text = userName;
			
			//render(spath:String, upath:String, size:Number)
		}
		
		public function setProfilePic(path:String):void
		{
			_Logo.addChild(_ProfilePicHolder);
			_ProfilePicHolder.render(_serverPath, _userPath, path, _profilePicSize);
		}
		
		public function setStageAlbum(stageAlbum:AlbumObject):void
		{
			_stageAlbum = stageAlbum;
			_hasAlbum = true;
		}
	
		public function makeGrid(gBoxSize:Number, gSpace:Number):void
		{
			trace("MAKEGRID() - gBoxSize: " + gBoxSize + " gSpace: " + gSpace);
			_currentPage = 1;
			_TriangleRight.setBox(true);
			_TriangleLeft.setBox(false);
			if(_allBoxes_arr.length != 0)
			{
				killKids();
			}
			_gBoxSize = gBoxSize;
			_gSpace = gSpace;
			_gDistance = _gBoxSize + _gSpace;
			
			_gRows = Math.ceil(_gHeight / _gDistance);
			_gCols = Math.ceil(_gLength / _gDistance);
			_gRows--;
			_gCols--;
		
			trace("GROWS: " + _gRows + " GCOLS: " + _gCols);
			var boxCount:int = 0;
			_allBoxes_arr = [];
			for (var py:int = 0; py<_gRows; py++) 
			{
				for (var px:int = 0; px<_gCols; px++) 
				{
					var box:Box = new Box();
					var tmpBoo:Boolean = false;
					
					if (boxCount < boxNum) 
					{
						tmpBoo = true;
						box.setBox(_gBoxSize , boxCount, tmpBoo, _gX + (_gDistance * px), box.y = _gY + (_gDistance * py));
						box.x = _gX + (_gDistance * px);
						box.y = _gY + (_gDistance * py);

						_allBoxes_arr.push(box);
						addChild(box);
						addKid(box);
						if(_hasAlbum)
						{
								var tmpMedia_arr:Array = _stageAlbum.getMediaArray();
								box.setPaths(_serverPath, _userPath);
								//makes box render image passed to it in 'render()'
								box.render(tmpMedia_arr[boxCount]);
						}
					}
					boxCount++;
				}
			}
			
			_boxesOnScreen = boxCount;
			trace("**_boxesOnScreen**: " + _boxesOnScreen);
			_totalPages = Math.ceil(boxNum / boxCount);
			
			if(_totalPages == 1)
			{
				_TriangleRight.setBox(false);
			}
			var tmpString:String = "1 / " + _totalPages.toString();
			_Pagination.setLabel(tmpString);
			
			if(_hasFullDisplayCover)
			{
				addChild(_FullDisplayCover);
			}			
		}
		
		public function nextGrid():void
		{
			_currentPage++;
			_TriangleLeft.setBox(true);
			
			if(_currentPage == _totalPages)
			{
				_TriangleRight.setBox(false);
			}
			trace("nextGrid");
			if(_allBoxes_arr.length != 0)
			{
				killKids();
				_allBoxes_arr = [];
			}
			
			var offSet:Number = _boxesOnScreen * (_currentPage - 1);
			trace("GROWS: " + _gRows + " GCOLS: " + _gCols);
			var boxCount:int = offSet;
			
			for (var py:int = 0; py<_gRows; py++) 
			{
				for (var px:int = 0; px<_gCols; px++) 
				{
					var box:Box = new Box();
					var tmpBoo:Boolean = false; //used to tell box if it should be active
					if (boxCount < boxNum) 
					{
						tmpBoo = true;
						_allBoxes_arr.push(box);
						box.setBox(_gBoxSize , boxCount, tmpBoo, _gX + (_gDistance * px), box.y = _gY + (_gDistance * py));

						box.x = _gX + (_gDistance * px);
						box.y = _gY + (_gDistance * py);

						_allBoxes_arr.push(box);
						//_allBoxes_arr[boxCount]=box;
						addChild(box);
						addKid(box);

						///////
						var tmpMedia_arr:Array = _stageAlbum.getMediaArray();
						box.setPaths(_serverPath, _userPath);
						//makes box render image passed to it in 'render()'
						box.render(tmpMedia_arr[boxCount]);
						/////////
					}
					
					boxCount++;
				}
			}
			
			var tmpString:String = _currentPage + " / " + _totalPages.toString();
			_Pagination.setLabel(tmpString);
			
		}
		
		public function lastGrid():void
		{
			_currentPage--;
			_TriangleRight.setBox(true);
			if(_currentPage == 1)
			{
				_TriangleLeft.setBox(false);
			}
			trace("nextGrid");
			if(_allBoxes_arr.length != 0)
			{
				killKids();
				_allBoxes_arr = [];
			}
			
			var offSet:Number = _boxesOnScreen * (_currentPage - 1);
			trace("GROWS: " + _gRows + " GCOLS: " + _gCols);
			var boxCount:int = offSet;
			
			for (var py:int = 0; py<_gRows; py++) 
			{
				for (var px:int = 0; px<_gCols; px++) 
				{
					var box:Box = new Box();
					var tmpBoo:Boolean = false; //used to tell box if it should be active
					if (boxCount < boxNum) 
					{
						tmpBoo = true;
						_allBoxes_arr.push(box);
						box.setBox(_gBoxSize , boxCount, tmpBoo, _gX + (_gDistance * px), box.y = _gY + (_gDistance * py));

						box.x = _gX + (_gDistance * px);
						box.y = _gY + (_gDistance * py);

						_allBoxes_arr.push(box);
						addChild(box);
						addKid(box);

						///////
						var tmpMedia_arr:Array = _stageAlbum.getMediaArray();
						box.setPaths(_serverPath, _userPath);
						//makes box render image passed to it in 'render()'
						box.render(tmpMedia_arr[boxCount]);
						/////////
					}
				
					
					boxCount++;
				}
			}
			var tmpString:String = _currentPage + " / " + _totalPages.toString();
			_Pagination.setLabel(tmpString);
		}
		
		/* 
		** fullDisplay is invoked when a user clicks on a thumbnail (Box.as) to display a full image of that thumb
		*/
		public function fullDisplay(mediaNumber:int):void
		{
			trace("FULLDISPLAY #: " + mediaNumber);
			
			_FullDisplayCover = new FullDisplayCover();
			_FullDisplayCover.setCover(_width, _height, _stageAlbum, _userPath, _serverPath, mediaNumber);
			addChild(_FullDisplayCover);
			_hasFullDisplayCover = true;
		}
		
		public function killFullDisplay():void
		{
			removeChild(_FullDisplayCover);
			_FullDisplayCover = null;
		
		}
		
		public function loginNav():void
		{
			_isLoggedIn = true;
			
		}
		
		private function initAll():void
		{
			trace("StageManager - initAll");
			
			theDocStage.stage.scaleMode = StageScaleMode.NO_SCALE;
            theDocStage.stage.align = StageAlign.TOP_LEFT;
            theDocStage.stage.addEventListener(Event.ACTIVATE, activateHandler);
            theDocStage.stage.addEventListener(Event.RESIZE, resizeHandler);
			initBackground();
		}
		
		private function initBackground():void
		{
				_border = new Sprite();
				_border.graphics.beginFill(_borderColor);
				_border.graphics.moveTo(0,0);
				_border.graphics.lineTo(0, 100);
				_border.graphics.lineTo(100, 100);
				_border.graphics.lineTo(100, 0);
				_border.graphics.lineTo(0,0);
				_border.graphics.endFill();
				//_border.alpha=.1;
				addChild(_border);

				_bk = new Sprite();
				_bk.graphics.beginFill(_bkColor);
				_bk.graphics.moveTo(0,0);
				_bk.graphics.lineTo(0, 100);
				_bk.graphics.lineTo(100, 100);
				_bk.graphics.lineTo(100, 0);
				_bk.graphics.lineTo(0,0);
				_bk.graphics.endFill();
				//_bk.alpha=.1;
				addChild(_bk);
			
				_topBar = new Sprite();
				_topBar.graphics.beginFill(_bkColor);
				_topBar.graphics.moveTo(0,0);
				_topBar.graphics.lineTo(0, 100);
				_topBar.graphics.lineTo(100, 100);
				_topBar.graphics.lineTo(100, 0);
				_topBar.graphics.lineTo(0,0);
				_topBar.graphics.endFill();
				addChild(_topBar);
				
				_botBar = new Sprite();
				_botBar.graphics.beginFill(_bkColor);
				_botBar.graphics.moveTo(0,0);
				_botBar.graphics.lineTo(0, 100);
				_botBar.graphics.lineTo(100, 100);
				_botBar.graphics.lineTo(100, 0);
				_botBar.graphics.lineTo(0,0);
				_botBar.graphics.endFill();
				addChild(_botBar);
				
				addChild(_TriangleRight);
				addChild(_TriangleLeft);
				_TriangleLeft.setBox(false);
				_TriangleLeft.setDirection("left");
				_TriangleRight.setDirection("right");
				_TriangleLeft.height = _botBar_height - (2 * _borderWidth);
				_TriangleRight.height = _botBar_height - (2 * _borderWidth);
				_TriangleLeft.scaleX *= -1;
				
				//_Logo.turnOnDebug();
				_Logo.y = 10;
				addChild(_Logo);
				addChild(_Pagination);
				addChild(_SearchField);
				
				_leftButtonX = 2.5 * _borderWidth;
				_SearchField.x = _leftButtonX;
				_LeftNav.x = _leftButtonX;
				addChild(_LeftNav);
				
				_FullScreenBut.setButton(0);
				
				addChild(_FullScreenBut);
				initBrowserScreen();
				
		}
		
		private function drawBackground():void
		{
			_border.width =  _width;
			_border.height = _height;
			
			_bk.width = _topBar_x - _borderWidth;
			_bk.height = _height - ( 2*_borderWidth);
			_bk.x = _borderWidth;
			_bk.y = _borderWidth;
			
			_topBar.y = _borderWidth;
			_topBar.x = _topBar_x + _borderWidth;
			_topBar.height = _topBar_height;
			_topBar.width = _width - _bk.width - (3 * _borderWidth);
			
			_botBar.y = _bk.height + - _botBar_height + _borderWidth;
			_botBar.x = _topBar_x + _borderWidth;
			_botBar.height = _botBar_height;
			_botBar.width = _width - _bk.width - (3 * _borderWidth);
			
			_TriangleLeft.y = _botBar.y + _borderWidth;
			_TriangleRight.y = _botBar.y + _borderWidth;
			
			_TriangleLeft.x = _botBar.x + _TriangleLeft.width + _borderWidth;
			_TriangleRight.x = _width - (2 * _borderWidth) - _TriangleRight.width;
			
			_Logo.x = _topBar_x + 2 *_borderWidth;
			_Logo.y = 7;
			//_Logo.y = (_topBar.y + _topBar.height/2) - (_Logo.height / 2); //center
			
			
			_FullScreenBut.scaleX = .5;
			_FullScreenBut.scaleY = .5;
			
			_FullScreenBut.x = _width - _FullScreenBut.width - 20;
			_FullScreenBut.y = 20;
			
			
			_Pagination.x = _botBar.x + ( _botBar.width / 2) - (_Pagination.width / 2);
			_Pagination.y = _height - _Pagination.height - (2 * _borderWidth);	
			_SearchField.y =  2 * _borderWidth;
			//_SearchField.y =  8 * _borderWidth;
		
			var tmpLeftNavHeight:Number = _height - _SearchField.height - (5 * _borderWidth);
			trace(">>>> tmpLeftNavHeight: " + tmpLeftNavHeight);
			
			//dispatchEvent(new ReSizeEvent(ReSizeEvent.CHANGESIZE, tmpLeftNavHeight/2 ));
			// _height - (3 * (_closedHeight + _spacing))
			var tmpContainerHeight:Number = tmpLeftNavHeight - (3 * (50 + _borderWidth));
			
			cdcStartHeight = tmpContainerHeight;
			
			dispatchEvent(new ReSizeEvent(ReSizeEvent.CHANGECONTSIZE, {tmpHeight:tmpContainerHeight}));
			dispatchEvent(new ReSizeEvent(ReSizeEvent.UPDATESIZE, {w:_width, h:_height}));
			trace(">>>>>>>>>>XXXXXXXXXXXXXXXXX>>>>>>>>>>>>>>>>>");
			
			_LeftNav.y = _SearchField.y + _SearchField.height +(1 * _borderWidth);
			_LeftNav.setParams(tmpLeftNavHeight , _activeLeftNavBut, 50, _borderWidth);
			
		}
		
		private function sendSize():void
		{
		
			var tmpLeftNavHeight:Number = _height - _SearchField.height - (5 * _borderWidth);
			var tmpContainerHeight:Number = tmpLeftNavHeight - (3 * (50 + _borderWidth));
			dispatchEvent(new ReSizeEvent(ReSizeEvent.CHANGECONTSIZE, {tmpHeight:tmpContainerHeight}));
			dispatchEvent(new ReSizeEvent(ReSizeEvent.UPDATESIZE, {w:_width, h:_height}));
			trace("SENT SENT SENT");
		}
		
		public function leftNavHit(which:int):void
		{
			if(which == 2 || which == 3)
			{
				if(_isLoggedIn)
				{
					var tmpLeftNavHeight:Number = _height - _SearchField.height - (5 * _borderWidth);

					var tmpContainerHeight:Number = tmpLeftNavHeight - (3 * (50 + _borderWidth));

					dispatchEvent(new ReSizeEvent(ReSizeEvent.CHANGECONTSIZE, {tmpHeight:tmpContainerHeight}));
					//////////
					_activeLeftNavBut = which;
					_SearchField.unGlow();
					_LeftNav.setParams(_height - _SearchField.height - (5 * _borderWidth) , _activeLeftNavBut, 50, _borderWidth);
				}
			}
			else
			{
				var tmpLeftNavHeight:Number = _height - _SearchField.height - (5 * _borderWidth);

				var tmpContainerHeight:Number = tmpLeftNavHeight - (3 * (50 + _borderWidth));

				dispatchEvent(new ReSizeEvent(ReSizeEvent.CHANGECONTSIZE, {tmpHeight:tmpContainerHeight}));
				//////////
				_activeLeftNavBut = which;
				_SearchField.unGlow();
				_LeftNav.setParams(_height - _SearchField.height - (5 * _borderWidth) , _activeLeftNavBut, 50, _borderWidth);
			}
			
		}
		
		private function activateHandler(event:Event):void 
		{
	       trace("activateHandler: " + event);
	    }

	    private function resizeHandler(event:Event):void 
		{
        	trace("resizeHandler: " + event);
        	trace("stageWidth: " + theDocStage.stage.stageWidth + " stageHeight: " + theDocStage.stage.stageHeight);
			_width = theDocStage.stage.stageWidth;
			_height = theDocStage.stage.stageHeight;
			
			dispatchEvent(new ReSizeEvent(ReSizeEvent.UPDATESIZE, {w:_width, h:_height}));
			//dispatchEvent(new ReSizeEvent(ReSizeEvent.CHANGECONTSIZE, {w:_width, h:_height}));
			
			
			_ScaleWarning.setSize(_width, _height);
			
			if(_height < 398 && _width < 420)
			{
				this.parent.addChild(_ScaleWarning);
				_ScaleWarning.setLabel("This application requires 400 pix of verticle space and 400 pix of horizontal space!")
				isScaleWarning = true;
			}
			else if(_height < 398)
			{
				this.parent.addChild(_ScaleWarning);
				_ScaleWarning.setLabel("This application requires 400 pix of verticle space!")
				isScaleWarning = true;
			}
			else if(_width < 420)
			{
				this.parent.addChild(_ScaleWarning);
				_ScaleWarning.setLabel("This application requires 400 pix of horizontal space!")
				isScaleWarning = true;
			}
			else
			{
				if(isScaleWarning)
				{
					this.parent.removeChild(_ScaleWarning);
					isScaleWarning = false;
				}
				_gLength = (_width) - _gX;
				_gHeight = (_height) - _gY - _botBar_height - _borderWidth;
				drawBackground();
				makeGrid(_gBoxSize, _gSpace);
				//if there is a FullDisplayCover like in fulldisplay mode make sure it's resized and on top.
				if(_hasFullDisplayCover)
				{
					//_FullDisplayCover.setCover(_width, _height);
					_FullDisplayCover.setSize(_width, _height);
					addChild(_FullDisplayCover);
				}
				
			}
			
        }

		 private function initBrowserScreen():void 
			{
	        	trace("stageWidth: " + theDocStage.stage.stageWidth + " stageHeight: " + theDocStage.stage.stageHeight);
				_width = theDocStage.stage.stageWidth;
				_height = theDocStage.stage.stageHeight;

				_ScaleWarning.setSize(_width, _height);

				if(_height < 398 && _width < 400)
				{
					this.parent.addChild(_ScaleWarning);
					_ScaleWarning.setLabel("This application requires 400 pix of verticle space and 400 pix of horizontal space!")
					isScaleWarning = true;
				}
				else if(_height < 398)
				{
					this.parent.addChild(_ScaleWarning);
					_ScaleWarning.setLabel("This application requires 400 pix of verticle space!")
					isScaleWarning = true;
				}
				else if(_width < 400)
				{
					this.parent.addChild(_ScaleWarning);
					_ScaleWarning.setLabel("This application requires 400 pix of horizontal space!")
					isScaleWarning = true;
				}
				else
				{
					if(isScaleWarning)
					{
						this.parent.removeChild(_ScaleWarning);
						isScaleWarning = false;
					}
					_gLength = (_width) - _gX;
					_gHeight = (_height) - _gY - _botBar_height - _borderWidth;
					drawBackground();
					makeGrid(_gBoxSize, _gSpace);
				}
	        }
	}
}

