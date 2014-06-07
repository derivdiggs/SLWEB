package com.sellproto.version1.view
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.net.*;
	import com.sellproto.version1.view.*;
	import com.sellproto.version1.events.*;
	import com.baseclasses.events.CustomEvent;
	import com.sellproto.version1.view.components.*;
	import com.sellproto.version1.datastorage.*;
	import com.baseclasses.components.containers.CustomDisplayContainer;
	import flash.net.FileReference;
	import flash.net.FileFilter;
	
	public class ViewController extends CustomSprite
	{
		public static var docStage:DisplayObject;
		private var _StageManager:StageManager;
		private var _GridSizeControl:SlideControl = new SlideControl();
		private var _GridSpaceControl:SlideControl = new SlideControl();
		private var _SearchType:CheckBoxRow = new CheckBoxRow();
		private var _ManageType:CheckBoxRow = new CheckBoxRow();
		private var _UploadType:CheckBoxRow = new CheckBoxRow();
		private var _browseButton:BasicButton = new BasicButton();
		private var _uploadButton:BasicButton = new BasicButton();
		private var _MyFileUpload:FileUpload = new FileUpload();
		private var _ImageLoader:ImageLoader;
		private var _UploadImageScreen:UploadImageScreen = new UploadImageScreen;
		private var _XMLProfileManager:XMLProfileManager;
		
		private var _uploadComponents_arr:Array = new Array;
		private var _searchComponents_arr:Array = new Array;
		private var _manageComponents_arr:Array = new Array;
		private var _prefComponents_arr:Array = new Array;
		private var _allComponents_arr:Array = new Array;
		private var _currentComponentSet:Number=0;
		private var _activeSection:int = -1;
		private var _gridSpacing:Number = 20;
		private var _gridBoxSize:Number = 125;
		private var _containerWidth:Number = 214;
		private var _containerHeight:Number;
		private var _cdc_arr:Array = new Array();
		private var _theStageWidth:Number;
		private var _theStageHeight:Number;
		private var _Cover:Cover = new Cover();
		private var _LogginScreen:LogginScreen;
		
		private var _isCover:Boolean = false;
		private var _isUploadImageScreen:Boolean = false;
		
		private var _userPath:String;
		private var _serverPath:String;
		private var _stageAlbum:AlbumObject;
		private var _userAlbum:AlbumObject;
		private var _userSettings:SettingsObject; //contains user preference data
		private var _isLoggedIn:Boolean = false; //if the user is logged in or not
		private var _loginClose:CloseButtonIcon;
		private var _userName:String;
		private var _AddNewMedia:AddNewMedia = new AddNewMedia();
		private var _uploadingFileName:String;
		private var _uploadInfo:Object = new Object();
		private var _isLoaderOnStage:Boolean = false;
		private var _manageAlbumStrip:AlbumStrip;
	
        public function ViewController()
        {
			trace("ViewController()");
			//_cdc.makeContainer(200,400,0xC00C11,0xCFFC55,10);
        	super();
        }
		
		public function initStageMNGR(docStage):void
		{
			
			_theStageHeight = docStage.stage.stageHeight;
			_theStageWidth = docStage.stage.stageWidth;
			
			
			///////
			_StageManager = new StageManager(docStage, 0x333333, 0x777777, 5, 230);
			_StageManager.addEventListener(NavEvent.BOTNAV, doNavHit);
			_StageManager.addEventListener(NavEvent.TOPNAV, doNavHit);
			_StageManager.addEventListener(NavEvent.BOXNAV, doNavHit);
			_StageManager.addEventListener(NavEvent.LEFTNAV, doNavHit);
			_StageManager.addEventListener(NavEvent.BASICBUT, doNavHit);
			_StageManager.addEventListener(ReSizeEvent.CHANGECONTSIZE, resizeContainers);
			_StageManager.addEventListener(ReSizeEvent.UPDATESIZE, updateStageSize);
			//_StageManager.makeGrid(_gridBoxSize, _gridSpacing);
			//addChild(_StageManager);
			
			//init and place all components
			trace(">>>>>>>>>>>>>>>>>>>> _cdcStartHeight: " + _StageManager.cdcStartHeight);
			
			
			_cdc_arr[0] = new CustomDisplayContainer;
			_cdc_arr[0].makeContainer(_containerWidth, 200, 0x555555, 0x777777, 1);
			_cdc_arr[0].x = 13;
			_cdc_arr[0].y = 76;
			_SearchType.x = 18;
			//_SearchType.y = 20;
			_SearchType.setCheckBoxRow("row_SearchType", null, 200, 1, "inclusive");
			_SearchType.addCheckBox("media", true);
			_SearchType.addCheckBox("album", true);
			_SearchType.addCheckBox("artist", false);
			_SearchType.addEventListener(CheckBoxRowEvent.ROWDATA, doRowHit);
			_cdc_arr[0].addContent(_SearchType, 25);
			
			
			_cdc_arr[1] = new CustomDisplayContainer;
			_cdc_arr[1].makeContainer(_containerWidth, _StageManager.cdcStartHeight, 0x555555,0x777777,1);
			_cdc_arr[1].x = 13;
			_cdc_arr[1].y = 131;
			_UploadType.x = 22;
			//_UploadType.y = 160;
			_UploadType.setCheckBoxRow("row_UploadType", null, 210, 1, "exclusive");
			_UploadType.addCheckBox("image", true);
			_UploadType.addCheckBox("song", false);
			_UploadType.addCheckBox("video", false);
			_UploadType.addEventListener(CheckBoxRowEvent.ROWDATA, doRowHit);
			_cdc_arr[1].addContent(_UploadType, 25);
			
			_uploadButton.setButton(2,"Upload");
			_browseButton.setButton(1,"Browse");
			_uploadButton.x = 19;
			_browseButton.x = 19;
			_uploadButton.addEventListener(NavEvent.BASICBUT, doNavHit);
			_browseButton.addEventListener(NavEvent.BASICBUT, doNavHit);
			
			_cdc_arr[1].addContent(_browseButton, 0);
			
			_uploadButton.visible = false;
			
			_cdc_arr[1].addContent(_uploadButton, -_uploadButton.height);
			
			_cdc_arr[1].addContent(_MyFileUpload, 10);
			
			
			
			
			_cdc_arr[2] = new CustomDisplayContainer;
			_cdc_arr[2].makeContainer(_containerWidth, _StageManager.cdcStartHeight, 0x555555,0x777777,1);
			_cdc_arr[2].x = 13;
			_cdc_arr[2].y = 187;
			_ManageType.x = 30;
			//_ManageType.y = 215;
			_ManageType.setCheckBoxRow("row_ManageType", null, 220, 1, "exclusive");
			_ManageType.addCheckBox("my albums", true);
			_ManageType.addCheckBox("my follows", false);
			_ManageType.addEventListener(CheckBoxRowEvent.ROWDATA, doRowHit);
			_cdc_arr[2].addContent(_ManageType, 25);
		
			
			
			_cdc_arr[3] = new CustomDisplayContainer;
			_cdc_arr[3].makeContainer(_containerWidth, _StageManager.cdcStartHeight, 0x555555,0x777777,1);
			_cdc_arr[3].x = 13;
			_cdc_arr[3].y = 242;
			_GridSizeControl.x = 17;
			//_GridSizeControl.y = 255;
			_GridSizeControl.setSlideControl(170, 50, 200, _gridBoxSize);
			_GridSizeControl.addEventListener(SlideControlEvent.CHANGENUMBER, doChangeGridSize);
			_cdc_arr[3].addContent(_GridSizeControl, 25);
			
			
			_GridSpaceControl.x = 17;
			//_GridSpaceControl.y = 310;
			_GridSpaceControl.setSlideControl(170, 0, 30, _gridSpacing);
			_GridSpaceControl.addEventListener(SlideControlEvent.CHANGENUMBER, doChangeGridSpace);
			_cdc_arr[3].addContent(_GridSpaceControl, 20);
			//create an array of all components
			
			_prefComponents_arr.push(_GridSizeControl);
			_prefComponents_arr.push(_GridSpaceControl);
			_uploadComponents_arr.push(_UploadType);
			_manageComponents_arr.push(_ManageType);
			_searchComponents_arr.push(_SearchType);
			
			_allComponents_arr[0] = _searchComponents_arr;
			_allComponents_arr[1] = _uploadComponents_arr;
			_allComponents_arr[2] = _manageComponents_arr;
			_allComponents_arr[3] = _prefComponents_arr;
			
			activateComponentSect(0);
			//addChild(_StageManager);
			
		}
		
		public function activateComponentSect(activateSection:int):void
		{
			
			trace("activateComponentSect--- activateSection: " + activateSection);
			if(_activeSection != -1)
			{
				removeChild(_cdc_arr[_activeSection]);
			}
			_activeSection = activateSection;
			
			for(var i:int=0;i<_allComponents_arr[_activeSection].length;i++)
			{
				addChild(_cdc_arr[_activeSection]);
			}
		}
		
		public function setPaths(spath:String, upath:String):void
		{
			_serverPath = spath;
			_userPath = upath;
			_MyFileUpload.setPaths(_serverPath, _userPath);
			_StageManager.setPaths(_serverPath, _userPath);
			_StageManager.setProfilePic(_userSettings.getProfilePic());
			
		}
		
		public function changeLoginStatus(isLoggedIn)
		{
			_isLoggedIn = isLoggedIn;
		}
		
		public function setStageAlbum(stageAlbum:AlbumObject):void
		{
			_stageAlbum = stageAlbum;
			_StageManager.boxNum = _stageAlbum.getTotalItems();
			_StageManager.setStageAlbum(_stageAlbum);
			_StageManager.makeGrid(_gridBoxSize, _gridSpacing);
			
			addChild(_StageManager);
			trace("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX SENDING XXXXXXXXXXXXXXXXXXXXXXXXXXXX _serverPath: "+_serverPath );
			_StageManager.setPaths(_serverPath, _userPath);
			//_StageManager.renderStageAlbum(_stageAlbum);
			activateComponentSect(_activeSection);
			
		}
		
		public function setUserAlbum(userAlbum:AlbumObject):void
		{
			_userAlbum = userAlbum;
			
		}
		
		public function passSettings(userSettings:SettingsObject):void
		{
			_userSettings = userSettings;
			_StageManager.setUserName(_userSettings.getUserName());
			trace("USER OVERRIDE: "+_userSettings.getUserName());
			
		}
		
		private function browseFile():void
		{
			_MyFileUpload.browseForUpload();
			_MyFileUpload.addEventListener(TryUploadEvent.CANCELUPLOAD, cancelCurrentUpload);
			_MyFileUpload.addEventListener(TryUploadEvent.PASSDATA, getUploadData);
			//_MyFileUpload.addEventListener("passUploadData", getUploadData);
			_uploadButton.visible = true;
			_browseButton.visible = false;
		}
		
		private function getUploadData(e:TryUploadEvent):void
		{
			trace("GOT UPLOAD DATA!!!! name: " + e.evtObj.name + " size: " + e.evtObj.size + " type: " + e.evtObj.type);
			_uploadInfo = e.evtObj;
		}
		
		private function uploadFile():void
		{
			/* when the user hits the upload button _MyFileUpload begins up
			// 
			*/
			launchUploadImageScreen();
			_MyFileUpload.addEventListener(TryUploadEvent.TRYUPLOAD, startUploadTimer);
			
			_MyFileUpload.uploadFile();
			_MyFileUpload.clearFileDisplay();
		}
		
		private function cancelCurrentUpload(e:TryUploadEvent):void
		{
			trace("!!!!!!!!!  cancelCurrentUpload()");
			_uploadButton.visible = false;
			_browseButton.visible = true;
		}
		
		private function launchUploadImageScreen():void
		{
			_Cover.setCover(_theStageWidth, _theStageHeight);
			addChild(_Cover);
			_UploadImageScreen.initAll(_theStageWidth, _theStageHeight);
			
			_UploadImageScreen.addEventListener(NavEvent.BASICBUT, doNavHit);
			addChild(_UploadImageScreen);
			_UploadImageScreen.setInfo(_uploadInfo);
			_isCover = true;
			_isUploadImageScreen = true;
		}
		
		private function removeUploadImageScreen():void
		{
			_isUploadImageScreen = false;
			_isCover = false;
			_UploadImageScreen.hideOptions();
			removeChild(_Cover);
			removeChild(_UploadImageScreen);
			removeChild(_ImageLoader);
			_uploadButton.visible = false;
			_browseButton.visible = true;
			//var _MyFileUpload:FileUpload = new FileUpload;
			dispatchEvent(new NewQueryEvent("newQuery", {terms:"refresh"}));
		}
		
		private function updateStageSize(e:ReSizeEvent):void
		{
			trace("udateStageSize")
			_theStageWidth = e.evtObj.w;
			_theStageHeight	= e.evtObj.h;
			
			if(_isCover)
			{
				_Cover.setCover(_theStageWidth, _theStageHeight);
			}
			
			if(_isUploadImageScreen)
			{
				_UploadImageScreen.setStage(_theStageWidth, _theStageHeight);
				_ImageLoader.setStage(_theStageWidth, _theStageHeight);
			}
		}
		
		private function startUploadTimer(e:TryUploadEvent):void
		{
			//
			trace(" XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "+ e.evtObj.name +" XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
			var tmpPath:String = e.evtObj.name;
			_uploadingFileName = e.evtObj.name;
			//var tmpPath:String = "images/" + e.evtObj.name;
			var tmp_arr:Array = new Array();
			tmp_arr.push(tmpPath);
			/*
			if(_isLoaderOnStage)
			{
				removeChild(_ImageLoader);
				_ImageLoader=null;
				_isLoaderOnStage = false;
			}
			*/
			_ImageLoader = new ImageLoader();
			_ImageLoader.setPaths(_serverPath, _userPath);
			_ImageLoader.setStage(_theStageWidth, _theStageHeight);
			_ImageLoader.addEventListener(TryUploadEvent.UPLOADCOMPLETE, uploadCompleteHandler);
			_ImageLoader.loadImages(tmp_arr);
			addChild(_ImageLoader);
			_isLoaderOnStage = true;
		}
		
		private function uploadCompleteHandler(e:TryUploadEvent):void
		{
			trace("DIMMS: " + e.evtObj.dimms);
			_uploadInfo.dimms = e.evtObj.dimms;
			_UploadImageScreen.showOptions(_uploadInfo.dimms);
			_uploadInfo.deg=0; //sets the current degrees of a new image to 0
		}
		
		private function resizeContainers(e:ReSizeEvent):void
		{
			trace(">>>  RESIZE!!! e.currentNumber: " + e.currentNumber);
			//_cdc.setContainer(200,e.currentNumber/2,0xC00C11,0xCFFC55,10);
		
			//var newHeight:Number = e.currentNumber-40;
			var newHeight:Number = e.evtObj.tmpHeight-40;
			_containerHeight = newHeight;
			_cdc_arr[0].setContainer(_containerWidth, newHeight);
			_cdc_arr[1].setContainer(_containerWidth, newHeight);
			_cdc_arr[2].setContainer(_containerWidth, newHeight);
			_cdc_arr[3].setContainer(_containerWidth, newHeight);
		}
		
		
		private function showAlbums():void
		{
			/*


			*/
			//setStrip(album:AlbumObject, wid:Number, high:Number, bkol:Number, brdcol:Number, _bwidth
			if(_manageAlbumStrip == null)
			{
				_manageAlbumStrip = new AlbumStrip();
			}
			_manageAlbumStrip.setStrip(_userAlbum, 150, _containerHeight);
		}
		
		private function doChangeGridSize(e:SlideControlEvent):void
		{
			_gridBoxSize = e.currentNumber;
			_StageManager.makeGrid(_gridBoxSize, _gridSpacing);
		}
		
		private function doChangeGridSpace(e:SlideControlEvent):void
		{
			_gridSpacing = e.currentNumber;
			_StageManager.makeGrid(_gridBoxSize, _gridSpacing);
		}
		
		private function doRowHit(e:CheckBoxRowEvent):void
		{
			trace(">>>>>>ROWDATA " + e.whichCheckBoxRow + " results_arr: " + e.results_arr);	 	
		}
		
		private function cancelUpload():void
		{
			removeUploadImageScreen();
		}
		
		private function goFullScreen():void
		{
		    if (stage.displayState == StageDisplayState.NORMAL) 
			{
		        stage.displayState=StageDisplayState.FULL_SCREEN;
		    } 
			else 
			{
		        stage.displayState=StageDisplayState.NORMAL;
		    }
		}
		
		private function promptLoggin():void
		{
			
			trace("**PROMPTLOGGIN()**")
			_Cover = new Cover();
			_LogginScreen = new LogginScreen();
			_LogginScreen.addEventListener(NavEvent.BASICBUT, doNavHit);
			_Cover.setCover(_theStageWidth, _theStageHeight);
			addChild(_Cover);
			_LogginScreen.x = (_theStageWidth - _LogginScreen.width) / 2;
			_LogginScreen.y = (_theStageHeight - _LogginScreen.height) / 4;
			addChild(_LogginScreen);
			_loginClose = new CloseButtonIcon();
			_loginClose.setButton(8);
			_loginClose.width = 18;
			_loginClose.height = 18;
			
			_loginClose.x = _theStageWidth - _loginClose.width - 10;
			_loginClose.y = 10;
			_loginClose.addEventListener(NavEvent.BASICBUT, doNavHit);
			addChild(_loginClose);
			_isCover = true;
		}
		
		private function killLoggin():void
		{
			removeChild(_Cover);
			removeChild(_LogginScreen);
			removeChild(_loginClose);
			_isCover = false;
		}
		
		private function loadProfile():void
		{
			dispatchEvent(new ChangeUserEvent(ChangeUserEvent.CHANGEUSER, _userName));
			
		}
		
		protected function newProfileDataComplete(e:CustomEvent):void
		{
			trace("** USER DATA LOAD COMPLETE ** USER DATA LOAD COMPLETE ** USER DATA LOAD COMPLETE **: "+_XMLProfileManager.mySettings);
			passSettings(_XMLProfileManager.mySettings);
			
		}
		
		private function doNavHit(e:NavEvent):void
		{
			trace("doTopNavHit() + e.from: " + e.whichButton);
			switch(e.type)
			{
				case "boxnav":
						
						addChild(_StageManager);
						_StageManager.fullDisplay(e.whichButton);
						
					break;
					
				case "botnav":
					
						switch(e.whichButton)
						{
							case 1:
								trace("b1");
								_StageManager.lastGrid();
								break;

							case 2:
								trace("b2");
								_StageManager.nextGrid();
								break;

							case 3:
								trace("b3");
								break;

							case 4:
								trace("b4");
								break;
								
							case 5:
								trace("b5");
								break;
						}
					break;
					
				case "leftnav":
						
						_StageManager.leftNavHit(e.whichButton);
						//activateComponentSect(e.whichButton-1);
						switch(e.whichButton)
						{
							case 1:
								trace("p1 search");
								//dispatchEvent(new NewQueryEvent("newQuery", {terms:"test"}));
								activateComponentSect(e.whichButton-1);
								
								break;

							case 2:
								trace("p2");
								//file upload section
								if(_isLoggedIn)
								{
									activateComponentSect(e.whichButton-1);
								}
								else
								{
									//activateComponentSect(e.whichButton-1);
									promptLoggin();
								}
								break;

							case 3:
								trace("p3");
								
								if(_isLoggedIn)
								{
									activateComponentSect(e.whichButton-1);
									showAlbums();
								}
								else
								{
									//activateComponentSect(e.whichButton-1);
									promptLoggin();
								}
								break;
								
							case 4:
								trace("p4");
								activateComponentSect(e.whichButton-1);
								//activateComponentSect(3);
							
								break;

							case 5:
								trace("p5");
								break;
						}
				break;
				
				case "basicbut":
						
						switch(e.whichButton)
						{
							case 0:
								trace("FULLSCREEN");
								goFullScreen();
								break;
								
							case 1:
								trace("bas1");
								browseFile();
								
								break;

							case 2:
								trace("bas2");
								uploadFile();
								break;

							case 3:
								trace("bas3");
								//user hits submit after uploading image
								var tmpVars:Object = new Object();
								tmpVars.name = _uploadingFileName;
								tmpVars.full = _uploadingFileName;
								tmpVars.thumb = _uploadingFileName;
								tmpVars.type = "image";
								tmpVars.author = _userName; //user name
								tmpVars.albumpath = "default.jpg";
								tmpVars.fromalbum = "default";
								tmpVars.authorpath = _userSettings.getProfilePic(); //name of user profile image
								tmpVars.upath = _userSettings.getUserPath();
								_UploadImageScreen.checkFields(tmpVars);
								cancelUpload();
								break;
								
							case 4:
								trace("bas4 cancel hit");
								cancelUpload();
								//activateComponentSect(3);
							
								break;

							case 5:
								trace("bas5");
								_StageManager.killFullDisplay();
								activateComponentSect(_activeSection);
								break;
								
							case 8:
								trace("close login window");
								
								killLoggin();
								
								break;
							
							case 9:
								
								_userName = _LogginScreen.getUserName();
								trace("bas9 login passed!! : " + _userName);
								killLoggin();
								_StageManager.loginNav();
								_isLoggedIn = true;
								loadProfile();
								//activateComponentSect(1);
								break;
								
							case 10:
								trace("rotate imagehit in uploadimagescreen");
								_ImageLoader.rotateImage(90);
								_uploadInfo.deg += 90;
								if(_uploadInfo.deg == 360)
								{
									_uploadInfo.deg = 0;
								}
								_UploadImageScreen.setRot(_uploadInfo.deg);
								trace("Current rotation in degrees: "+_uploadInfo.deg);
								break;
						}
				break;	
			}
		}
	}
}

