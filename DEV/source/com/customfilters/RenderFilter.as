package com.customfilters
{

	import flash.display.*;
	import com.customfilters.view.ViewController
	
	public class RenderFilter extends Sprite
		{
			private var _ViewController:ViewController;
			private static var _docStage:DisplayObject;
		
			public function RenderFilter()
				{
					trace("RenderFilter()");
					
					
					_docStage = this.stage;
					trace("DOC STAGE: " + _docStage.stage.height);
					super();
					initAll();
				
				}
				
			private function initAll()
				{
					_ViewController = new ViewController();
					_ViewController.initStage(_docStage);
					addChild(_ViewController);
					
				}
		
		
		}
	
}