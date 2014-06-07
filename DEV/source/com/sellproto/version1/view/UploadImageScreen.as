package com.sellproto.version1.view
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import com.sellproto.version1.view.*;
	import com.sellproto.version1.events.*;
	import com.sellproto.version1.view.AddNewMedia;
	import flash.net.*;
	import gs.*;
	import gs.easing.*;


	public class UploadImageScreen extends MovieClip
	{
		
		public var tags:String;
		private var _AddNewMedia:AddNewMedia = new AddNewMedia();
		private var _width:Number;
		private var _height:Number;
		private var _info:Object = new Object(); // holds info about the image loaded
		
        
        public function UploadImageScreen()
        {
			trace("UploadImageScreen()");
			trace("_AddNewMedia: "+_AddNewMedia);
			
        	super();
			//initAll();
        }

		public function doSubmit(e:NavEvent):void
		{
			trace("SUBMIT SUBMIT INSIDE UPLOADIMAGESCREEN");
		}

		public function setStage(width:Number, height:Number):void
		{
			trace("uploadimagescreen width: " + width);
			
			_width = width;
			_height = height;
			
			var spaceBetweenButtons:Number = 20;
			var buttonsWidth = (_fields._cancelButton.width + spaceBetweenButtons + _fields._submitButton.width);
			
			_fields._cancelButton.y = _height - _fields._cancelButton.height-30;
			_fields._submitButton.y = _height - _fields._submitButton.height-30;
			
			_fields.x = (_width - _fields.width) / 2;
			_fields.y = 10;
			_fields._bk.height = _height - 20;
		}
		
		public function initAll(width:Number, height:Number):void
		{
			_fields._submitButton.addEventListener(NavEvent.BASICBUT, doSubmit);
			
			setStage(width, height);
			TweenMax.to(_fields, 1, {glowFilter:{color:0x8989F5, alpha:1, blurX:20, blurY:20}});
			_fields._tags_it.visible = false;
			_fields._label1.visible = false;
			_fields._price_it.visible = false;
			_fields._price_st.visible = false;
			_fields._rotate_but.visible = false;
			
			_fields._submitButton.setButton(3,"Submit");
			_fields._cancelButton.setButton(4,"Cancel");
			_fields._rotate_but.setButton(10,"rotate");
		}
		
		public function setMediaProps(evtObj:Object):void
		{
			//_fields._submitButton.setButtonVarObject(evtObj):
		}
		
		public function setInfo(info:Object):void
		{
			//recieves name and size of file
			_info = info;
		}
		
		public function setRot(rotation:Object):void
		{
			//recieves name and size of file
			_info.rotation = rotation;
		}
		
		private function setInfoDT():void
		{
			_fields._info_dt.text = "Name: " + _info.name +"   Size: " + _info.dimms + "   Size(k): " + _info.size;	
		}
		
		public function showOptions(dimms:String):void
		{
			_fields._tags_it.visible = true;
			_fields._price_it.visible = true;
			_fields._label1.visible = true;
			_fields._price_st.visible = true;
			_fields._cancelButton.visible = true;
			_fields._submitButton.visible = true;
			_fields._rotate_but.visible = true;
			_info.dimms = dimms;
			clearData();
			setInfoDT();
		}
		
		//clears text fields
		private function clearData():void
		{
			_fields._tags_it.text = "";
			_fields._info_dt.text = "";
			_fields._price_it.text = "";
		}
		
		public function checkFields(knownVars:Object):void
		{
			
			trace("_tags_it: " + _fields._tags_it.text);
			var vars:URLVariables = new URLVariables();
			vars.full = knownVars.full;
			vars.rotation = _info.rotation;
			vars.thumb = knownVars.thumb;
			vars.name = knownVars.name;
			vars.author = knownVars.author;
			vars.tags = _fields._tags_it.text;
			trace("got vars: " + vars.author);
			
			vars.type = "image";
			vars.authorpath = knownVars.authorpath;
			vars.albumpath = knownVars.albumpath;
			vars.fromalbum = knownVars.fromalbum;
			vars.upath = knownVars.upath;
			vars.price = _fields._price_it.text;
			vars.quality = _info.dimms; //in the case of images quality is pixel dimmensions
			vars.size = _info.size; //the files siz in kbytes
			_AddNewMedia.addMedia(vars); //sends vars to database
		}
		
		public function hideOptions():void
		{
			_fields._cancelButton.visible = false;
			_fields._submitButton.visible = false;
			_fields._price_it.visible = false;
			_fields._tags_it.visible = false;
			_fields._label1.visible = false;
			_fields._price_st.visible = false;
			_fields._rotate_but.visible = false;
			clearData();
		}
		
	}
}

