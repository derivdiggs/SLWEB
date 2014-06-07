package com.ddiggs.transitions.view{

	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import com.ddiggs.transitions.baseclasses.CustomSprite;
	import com.ddiggs.transitions.events.CustomEvent;
	import com.ddiggs.transitions.view.BitBorder;

	public class BitHolder extends CustomSprite{
		
		private var _x:Number = new Number();
		private var _y:Number = new Number();
		private var _width:Number = new Number();
		private var _height:Number = new Number();
		
		
		public function BitHolder(bitX:Number, bitY:Number, bitW:Number, bitH:Number):void{
			
			this._x = bitX;
			this._y = bitY;
			this._width = bitW;
			this._height = bitH;
			super();
		}
	}
}