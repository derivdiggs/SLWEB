package com.ddiggs.transitions
{
	
	import flash.display.*;
	import flash.geom.Rectangle;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import com.ddiggs.transitions.baseclasses.BaseRect;
	import com.ddiggs.transitions.baseclasses.CustomSprite;
	import com.ddiggs.transitions.events.CustomEvent;
	import com.ddiggs.transitions.view.BitHolder;
	import com.ddiggs.transitions.view.PicHolder;
	import com.ddiggs.transitions.view.TransMask;
	import gs.*;
	import gs.easing.*;
	import gs.plugins.*;
	
	
		
	public class TransitionRenderer extends CustomSprite{
			
		private var _imageURLs:Array;
		private var _imageArray:Array;
		private var _transitionTime:int;
		private var _rowDivisions:int;
		private var _colDivisions:int;
		private var _allMasks:Array;
		private var _docStage:DisplayObject;
		private var _totalBoxes:int;
		private var _doneBoxCount:int;
		private var _id:int;
		
			
		public function TransitionRenderer(){
			trace("TransitionRenderer()");
			initAll();
		}
		
		private function initAll(){
			_imageArray = [];
			_allMasks = [];
			_totalBoxes = 0;
			_doneBoxCount = 0;
			
		}
			
		public function createTransition(id:int, imageURLs:Array, transitionTime:int, rowDivisions:int, colDivisions:int){
			
			_id = id;
			_imageURLs = imageURLs;
			_transitionTime = transitionTime;
			_rowDivisions = rowDivisions;
			_colDivisions = colDivisions;
			
			makeImageArray(_imageURLs)
		}
		
		private function makeImageArray(images:Array){
			
			for (var i:int = 0; i<images.length; i++){

				var pic = new PicHolder();
				pic.addEventListener("picLoaded", picLoadComplete);
				pic.loadImage(images[i],1);
				_imageArray.push(pic);
			}
		}
		
		private function picLoadComplete(e:CustomEvent):void
		{
			sliceBitmap(_imageArray[0]);
			var _type:String = "hello";
			dispatchEvent(new CustomEvent("picLoaded", {type:_type}));
		}
		
		private function sliceBitmap(mImage):void{
			
		       var mainImage:BitmapData = mImage.myBitmapData;
		       var tileX:Number = _rowDivisions; 
		       var tileY:Number = _colDivisions;
		       var bitmapArray:Array;

		       var tilesH:uint = Math.ceil(mainImage.width / tileX); // Number  of Columns
		       var tilesV:uint = Math.ceil(mainImage.height / tileY);// Number of Rows
			   
			   var row_ar:Array = [];
		       bitmapArray = new Array();

		       for (var i:Number = 0; i < tilesH; i++)
		       {
		           bitmapArray[i] = new Array();
		           for (var n:Number = 0; n < tilesV; n++)
		           {
		               var tempData:BitmapData=new BitmapData(tileX,tileY);
		               var tempRect = new Rectangle((tileX * i),(tileY * n),tileX,tileY);
		               tempData.copyPixels(mainImage,tempRect,new Point(0,0));
		               bitmapArray[i][n]=tempData;
		           }
		       }
			   var myGrid:Sprite = new Sprite();
			   var cnt:int = 0;
		       for (var j:uint =0; j<bitmapArray.length; j++)
		       {
				   row_ar=[];
		           for (var k:uint=0; k<bitmapArray[j].length; k++)
		           {

		              var bitmap:Bitmap=new Bitmap(bitmapArray[j][k]);
					  var myImage:BitHolder = new BitHolder((k * _rowDivisions),(j * _colDivisions), _rowDivisions, _colDivisions);
					  //bitmap.alpha = 0;
		              myImage.addChild(bitmap);
					  myImage.alpha = 0;
					  addChild(myImage);
					  var myGrid:Sprite = new Sprite();

					  myGrid.graphics.lineStyle(1, 0xffffff, .9);
					  
					  
					  myGrid.graphics.moveTo(j * bitmap.width, k * bitmap.height); 
					  myGrid.graphics.lineTo((j+1) * bitmap.width, k * bitmap.height);
					  TweenLite.to(myGrid, .5, {delay:(((bitmapArray[j].length- k)*.08)), alpha:0});
					  myImage.addChild(myGrid);
				
		              bitmap.x = j * bitmap.width;
		              bitmap.y = k * bitmap.height;
					  row_ar.push(myImage);
					  _totalBoxes++;
		           }
				   _allMasks[j]=(row_ar);
		       }
			   animateTransition(_allMasks);
			   addChild(myGrid);
		}
		
		private function animateTransition(masksArray:Array):void{
			
			var i:int = 0;
			for (var col:int = 0; col < masksArray.length; col++){
					
				for (var row:int = 0; row < masksArray[col].length; row++){
						
					masksArray[col][row].y = getRandom(-60,120);
					//masksArray[col][row].x = getRandom(-40,80);
					//var inDelay:int = getRandom(1,50)*.1;
					TweenLite.to(masksArray[col][row], 0, {tint:0x333399});
					
					TweenLite.to(masksArray[col][row], 8, {tint:null, onComplete:trackProgress});
					TweenMax.to(masksArray[col][row], (1), {x:0, y:0, ease:Quad.easeIn, delay:getRandom(1,50)*.1 + _transitionTime, alpha:1});
					
					i++;
				}
			}	
		}
		
		private function trackProgress():void{
			
			_doneBoxCount++;
			if( _doneBoxCount == _totalBoxes){
				
				trace("BOXTRANSITIONS COMPLETE");
				dispatchEvent(new CustomEvent("transComplete", {id:_id}));
			}
		}
		
		private function onMouseMove(evt:MouseEvent){
			//trace(evt.target.mouseY);
			var target:* = evt.target;
			//_foo.text = target.mouseY;
			//_foo.text = evt.localY.toString();

			var location:Point = new Point(target.mouseX, target.mouseY);
			location = target.localToGlobal(location);
			trace(target.mouseY + ": "+ location.y);
			var _type:Object = {x:target.mouseX, y:target.mouseY};
			for (var col:int = 0; col < _allMasks.length; col++){
					
				for (var row:int = 0; row < _allMasks[col].length; row++){
					
					_allMasks[col][row].tellCoords(target.mouseX, target.mouseY);
				}
			}
		}
		
		protected function picLoaded(e:CustomEvent){
			
			
		}	
	}
}