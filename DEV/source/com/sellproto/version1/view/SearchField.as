package com.sellproto.version1.view
{

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import gs.*;
	import gs.easing.*;

	public class SearchField extends MovieClip
	{
        
        public function SearchField()
        {
			trace("SerachField()");
        	super();
			//_search_it.addEventListener(Event.CHANGE, changeHandler);
        }

		public function reNit():void
		{
			
				//_search_it.addEventListener(Event.CHANGE, changeHandler);
		}

		public function unGlow():void
		{
			TweenMax.to(_outline, .5, {alpha:0});
		}
		
		private function changeHandler(e:Event):void 
		{
			//trace("EVENT: " + e.type);
			TweenMax.to(_outline, .5, {alpha:1});
        }
	}
}

