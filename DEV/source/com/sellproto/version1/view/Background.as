package com.sellproto.version1.view
{

import flash.display.*;
import flash.utils.*;
import flash.events.*;
import flash.geom.Point;

	public class Background extends Sprite
	{
	public var connectorBox:Sprite;
		
        
        public function Background()
        {
			trace("Background()");
        	super();
			initAll();
        }
		
		private function initAll():void
		{
			connectorBox = new Sprite();
			connectorBox.graphics.beginFill(0x004d84);
			connectorBox.graphics.moveTo(0,0);
			connectorBox.graphics.lineTo(0,100);
			connectorBox.graphics.lineTo(100,100);
			connectorBox.graphics.lineTo(100,0);
			connectorBox.graphics.lineTo(0,0);
			connectorBox.graphics.endFill();
			connectorBox.alpha = .8;
			addChild(connectorBox);
			connectorBox.stage.displayState = "StageDisplayState.FULL_SCREEN";
			//trace("stageWidth: " + connectorBox.stage.stageWidth + " stageHeight: " + connectorBox.stage.stageHeight);
		}
		
		
	
	}

}

