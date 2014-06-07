package com.ddiggs.transitions.baseclasses{
	
	import flash.display.*
	import flash.events.*
	import com.ddiggs.transitions.baseclasses.Rect
		
	public class BasicStage extends Sprite{
		
		private var _docStage:DisplayObject;
		private var _docStageWidth:int;
		private var _docStageHeight:int;
		private var _myStageWidth:int;
		private var _myStageHeight:int;
		private var _stageBorder:Sprite;
		
		public function BasicStage():void{
			
			//trace(">DOC STAGE: " + docStage.stage.height);
			//trace(">stage: " + docStage.stage);
			super();
		}
		
		public function initStage(docStage:DisplayObject, myStageWidth:int, myStageHeight:int):void{
		
			_docStage = docStage;
			_docStageWidth = _docStage.stage.stageWidth;
			_docStageHeight = _docStage.stage.stageHeight;
			_myStageWidth = myStageWidth;
			_myStageHeight = myStageHeight;
			_docStage.stage.scaleMode = StageScaleMode.NO_SCALE;
            _docStage.stage.align = StageAlign.TOP_LEFT;
            _docStage.stage.addEventListener(Event.RESIZE, resizeHandler);
			_stageBorder = new Sprite();
			_stageBorder = outlineMyStage(_myStageWidth, _myStageHeight);
			
			addChild(_stageBorder);
			trace("BasciStage _docStageWidth " + _docStageWidth);
			trace("BasciStage _docStageHeight " + _docStageHeight);
		
		}
		
		protected function centerItem(item:DisplayObject):void{
			
			trace("STAGE item.width: " +item.width);
			item.x = (_myStageWidth - item.width) / 2;
		}
		
		private function outlineMyStage(wid:int, high:int):Sprite{
			
			
			//_bkColor = bkColor;
			//_alpha = alph;
			var rect:Sprite = new Sprite();
			//rect.graphics.beginFill(0xffffff);
			rect.graphics.lineStyle(1, 0xffffff);
			rect.graphics.moveTo(0,0);
			rect.graphics.lineTo(0, high-1);
			rect.graphics.lineTo(wid-1, high-1);
			rect.graphics.lineTo(wid-1, 0);
			rect.graphics.lineTo(0,0);
			//rect.graphics.endFill();
			//rect.alpha=0;
			return rect;
		}
		
	    private function resizeHandler(event:Event):void{
		
			_docStageWidth = _docStage.stage.stageWidth;
			_docStageHeight = _docStage.stage.stageHeight;
			trace("BasciStage _docStageWidth " + _docStageWidth);
			trace("BasciStage _docStageHeight " + _docStageHeight);
			this.x = (_docStageWidth - _myStageWidth) / 2;
		}
		
		public function get docStageWidth():int{
		
			return _docStageWidth;
		}
		
		public function get docStageHeight():int{
		
			return _docStageHeight;
		}
	}
}