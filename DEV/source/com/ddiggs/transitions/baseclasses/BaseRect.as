package com.ddiggs.transitions.baseclasses
{
	import flash.display.*;
	
	
	public class BaseRect extends Sprite
	{
		private var _height:Number;
		private var _width:Number;
		private var _borderColor:Number;
		private var _bkColor:Number;
		private var _rect:Sprite;
		private var _alpha:Number = 1;
		
		public function BaseRect():void
		{
			super();
		}
		
		public function makeBaseRect(wid:Number, high:Number, bkColor:Number, alph:Number):Sprite
		{
			_width = wid;
			_height = high;
			_bkColor = bkColor;
			_alpha = alph;
			_rect = new Sprite();
			_rect.graphics.beginFill(_bkColor);
			_rect.graphics.moveTo(0,0);
			_rect.graphics.lineTo(0, _height);
			_rect.graphics.lineTo(_width, _height);
			_rect.graphics.lineTo(_width, 0);
			_rect.graphics.lineTo(0,0);
			_rect.graphics.endFill();
			_rect.alpha=_alpha;
			return _rect;
		}
		
		public function setBaseRect(wid:Number, high:Number):void
		{
			_width = wid;
			_height = high;
			_rect.width = _width;
			_rect.height = _height;
		}
		
	
		
	
	}
}