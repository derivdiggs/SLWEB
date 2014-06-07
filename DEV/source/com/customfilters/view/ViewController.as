package com.customfilters.view{
		import flash.display.*;
		
		import com.ddiggs.transitions.view.StageView
		
		
		public class ViewController extends Sprite{
			//private var _TransitionRenderer:TransitionRenderer;
			//private var _imageArray:Array
			private var _StageView: StageView;
			private var _myStage: DisplayObject;
		
			public function ViewController(){
				
				trace("ViewController()")
					
			}
			
			public function initStage(myStage:DisplayObject){
				
				_myStage = myStage;
				trace("VC myStage: " + _myStage);
				_StageView = new StageView();
				_StageView.initStage(_myStage, 800, 600);
				addChild(_StageView);
			
			}
			
			private function testImageLoad(){
				
				//_imageArray.push("images/image1.jpg");
				//_TransitionRenderer.createTransition(_imageArray,5,10,15);
				
			}
			
			
		}
	
}