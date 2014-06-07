package com.ddiggs.transitions.view{
	import flash.display.*;
	import flash.net.*;
	import com.ddiggs.transitions.baseclasses.BasicStage;
	import com.ddiggs.transitions.TransitionRenderer;
	import com.ddiggs.transitions.events.CustomEvent;
	import com.ddiggs.transitions.view.*;
	import gs.*;
	import gs.easing.*;
	import gs.plugins.*;
	
	public class StageView extends BasicStage{
		
		private var _TransitionRenderer:TransitionRenderer;
		private var _imageArray:Array
		private var _MyLogo:MyLogo = new MyLogo();
		private var _City:City = new City();
		private var _CityBW:CityBW = new CityBW();
		private var _Sky:Sky = new Sky();
		private var _SkyBW:SkyBW = new SkyBW();
		private var _MultButton:MultButton = new MultButton();
		private var _RecButton:RecButton = new RecButton();
		private var _circleHolder:Sprite = new Sprite;
		private var _circleMaskHolder:Sprite = new Sprite;
		private var _circleMaskHolder2:Sprite = new Sprite;
		
		public function StageView():void{
		
			super();
			initAll();
		}
		
		private function initAll():void{
			
			_TransitionRenderer = new TransitionRenderer();
			_imageArray = new Array();
			//_TransitionRenderer.x = 100;
			_TransitionRenderer.addEventListener("picLoaded", picLoadComplete);
			_TransitionRenderer.addEventListener("transComplete", transComplete);
			_RecButton.addEventListener("NavEvent", buttonHit);
			_City.alpha = 0;
			_CityBW.alpha = 0;
			_Sky.alpha = 0;
			_SkyBW.alpha = 0;
			addChild(_Sky);
			addChild(_SkyBW);
			addChild(_City);
			addChild(_CityBW);
			addChild(_TransitionRenderer);
			_City.y = 2;
			_CityBW.y = 2;
			_MultButton.y = 501;
			_MultButton.x = 594;
			_MultButton.alpha = 0;
			_RecButton.y = 501;
			_RecButton.x = 44;
			_RecButton.alpha = 0;
			//_MultButton.setButton(1);
			_RecButton.setButton(2);
			addChild(_MultButton);
			addChild(_RecButton);
			testImageLoad();
			
		}
		
		
		private function testImageLoad(){
			//imageURLs:Array, transitionTime:int, divisions:int
			//_imageArray.push("images/image3.jpg");
			_imageArray.push("images/NYSkyline.jpg");
			_TransitionRenderer.createTransition(1, _imageArray, 0, 40, 10);
		}
		
		private function picLoadComplete(e:CustomEvent):void{
			
			centerItem(_TransitionRenderer);
			//centerItem(_MyLogo);
			var circle:Shape = new Shape(); // The instance name circle is created
			circle.graphics.beginFill(0x000000, .5); // Fill the circle with the color 990000
			circle.graphics.lineStyle(1, 0xffffff); // Give the ellipse a black, 2 pixels thick line
			circle.graphics.drawCircle(400, 260, 216); // Draw the circle, assigning it a x position, y position, raidius.
			circle.graphics.endFill(); // End the filling of the circle
			_circleHolder.addChild(circle);
			_circleHolder.alpha = 0;
			addChild(_circleHolder);
			
			var circleMask:Shape = new Shape(); // The instance name circle is created
			circleMask.graphics.beginFill(0x000000, 1); // Fill the circle with the color 990000
			circleMask.graphics.lineStyle(1, 0xffffff); // Give the ellipse a black, 2 pixels thick line
			circleMask.graphics.drawCircle(400, 260, 216); // Draw the circle, assigning it a x position, y position, raidius.
			circleMask.graphics.endFill(); // End the filling of the circle
			_circleMaskHolder.addChild(circleMask);
			
			var circleMask2:Shape = new Shape(); // The instance name circle is created
			circleMask2.graphics.beginFill(0x000000, 1); // Fill the circle with the color 990000
			circleMask2.graphics.lineStyle(1, 0xffffff); // Give the ellipse a black, 2 pixels thick line
			circleMask2.graphics.drawCircle(400, 260, 216); // Draw the circle, assigning it a x position, y position, raidius.
			circleMask2.graphics.endFill(); // End the filling of the circle
			_circleMaskHolder2.addChild(circleMask2);
			
			
			_MyLogo.x = 205;
			_MyLogo.y = 110;
			_MyLogo.alpha = 0;
			TweenMax.to(_MyLogo, 0, {blurFilter:{blurX:400}});
			TweenMax.to(_MyLogo, 5, {blurFilter:{delay:5, blurX:0, ease:Bounce.easeInOut}, onComplete:animateTitle});
			TweenMax.to(_MyLogo, 6, {alpha:1});
			TweenMax.to(_circleHolder, 4, {alpha:.8});
			TweenMax.to(_circleHolder, 4, {delay:4,alpha:.5});
			//TweenMax.to(_TransitionRenderer, 1, {alpha:0, delay:10, onComplete:playMain});
			
			
			addChild(_MyLogo);
		}
		
		private function transComplete(e:CustomEvent):void{
			
			//_Sky.mask = _MyLogo;
			addChild(_circleMaskHolder);
			_CityBW.mask = _circleMaskHolder;
			_SkyBW.mask = _circleMaskHolder2;
			_CityBW.alpha = 1;
			_Sky.alpha = 1;
			_SkyBW.alpha = 1;
			_City.alpha = 1;
			_TransitionRenderer.alpha = 0;
			removeChild(_TransitionRenderer);
			
			//TweenMax.to(_RecButton, 1, {alpha:.9, x:444, ease:Bounce.easeInOut});
			//TweenMax.to(_MultButton, 1, {alpha:.9, x:194, ease:Bounce.easeInOut});
			TweenMax.to(_Sky, 500, {width:2124, height:607, x:-1150, y:-100});
			TweenMax.to(_SkyBW, 500, {width:2124, height:607, x:-1150, y:-100});
			TweenMax.to(_City, 360, {width:1600, height:1200, x:-23, y:-300});
			TweenMax.to(_CityBW, 360, {width:1600, height:1200, x:-23, y:-300});
			
		}
		
		private function animateTitle():void{
			
			_MyLogo.play();
			TweenMax.to(_RecButton, 1, {delay:2, alpha:.9, x:444, ease:Quint.easeOut});
			TweenMax.to(_MultButton, 1, {delay:2, alpha:.9, x:194, ease:Quint.easeOut});
		}
		
		private function buttonHit(e:CustomEvent):void{
			
			trace("BUTTON HEARD id: " + e.evtObj.id);
			if(e.evtObj.id == 2){
				
				navigateToURL(new URLRequest("http://thoughtrender.com/music"));
			}
		}
		
	}
}