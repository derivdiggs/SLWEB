package com.ddiggs.transitions.view
{
	import flash.display.*;
	import com.ddiggs.transitions.baseclasses.Rect
	
	
	public class BitBorder extends Sprite{
		
		public function BitBorder():void{
		
			super();
		}
		
		public function makeBorder(_x:Number, _y:Number, wid:Number, high:Number, borderColor:Number, borderWidth:Number):Sprite{
			
			var square:Sprite = new Sprite();
			
			square.graphics.lineStyle(borderWidth,borderColor);
			square.graphics.drawRect(_x, _y, wid, high);
			//addChild(square);
			return square;
			
		}
	}
}