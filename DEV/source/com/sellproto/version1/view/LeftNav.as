package com.sellproto.version1.view
{

import flash.display.*;
import flash.utils.*;
import flash.events.*;
import com.sellproto.version1.view.*;
import gs.*;
import gs.easing.*;

	public class LeftNav extends Sprite
	{
		private var _height:Number;
		private var _active:int;
		private var _closedHeight:Number;
		private var _spacing:Number;
		private var _Search_btn:LeftButton = new LeftButton();
		private var _Upload_btn:LeftButton = new LeftButton();
		private var _Manage_btn:LeftButton = new LeftButton();
		private var _Preferences_btn:LeftButton = new LeftButton();
		private var _btn_arr:Array = new Array;
		private var _isLoggedIn:Boolean=false;
        
        public function LeftNav()
        {
			trace("LeftNav()");
        	super();
			initAll();
        }

		public function setParams(myHeight:Number, active:int, closedHeight:Number, spacing:Number):void
		{
			_height = myHeight;
			_active = active;
			_closedHeight = closedHeight;
			_spacing = spacing;
			
			var activeHeight:Number = _height - (3 * (_closedHeight + _spacing));
			for(var i:int=0;i<_btn_arr.length;i++)
			{
				if(_active == i +1)
				{
					_btn_arr[i].isSelected(true);
					_btn_arr[i].setHeight(activeHeight);
				}
				else
				{
					_btn_arr[i].isSelected(false);
					_btn_arr[i].setHeight(_closedHeight);
				}	
			}
			
			switch(_active)
			{
				case 1:
					_Upload_btn.y = activeHeight + _spacing;
					_Manage_btn.y = (activeHeight + _spacing) + (1 * (_closedHeight + _spacing));
					_Preferences_btn.y = (activeHeight + _spacing) + (2 * (_closedHeight + _spacing));
				break;
				
				case 2:
					_Upload_btn.y = (1 * (_closedHeight + _spacing));
					_Manage_btn.y = (activeHeight + _spacing) + (1 * (_closedHeight + _spacing));
					_Preferences_btn.y = (activeHeight + _spacing) + (2 * (_closedHeight + _spacing));
				break;
				
				case 3:
					_Upload_btn.y = (1 * (_closedHeight + _spacing));
					_Manage_btn.y = (2 * (_closedHeight + _spacing));
					_Preferences_btn.y = (activeHeight + _spacing) + (2 * (_closedHeight + _spacing));
				break;
				
				case 4:
					_Upload_btn.y = (1 * (_closedHeight + _spacing));
					_Manage_btn.y = (2 * (_closedHeight + _spacing));
					_Preferences_btn.y = (3 * (_closedHeight + _spacing));
				break;
			}
		}
		
		public function setLoginTrue():void
		{
			_isLoggedIn = true;
			_Upload_btn.setReady();
			_Manage_btn.setReady();
		}
		
		private function initAll():void
		{
			_Search_btn.setButton(1, "Search");
			_btn_arr.push(_Search_btn);
			_Upload_btn.setButton(2, "Upload");
			_btn_arr.push(_Upload_btn);
			_Manage_btn.setButton(3, "Manage");
			_btn_arr.push(_Manage_btn);
			_Preferences_btn.setButton(4, "Preferences");
			_btn_arr.push(_Preferences_btn);

			addChild(_Search_btn);
			addChild(_Upload_btn);
			addChild(_Manage_btn);
			addChild(_Preferences_btn);	
		}
	}
}