package com.sellproto.version1.view
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.*;
	import flash.net.*;
	import flash.net.FileReference;
	import flash.net.FileFilter;
	import com.sellproto.version1.events.TryUploadEvent;
	import com.baseclasses.events.CustomEvent;
	

	public class FileUpload extends Sprite 
	{
		private var _output:TextField;
		//private var _URLrequest:URLRequest = new URLRequest("http://www.flashturnaround.com/test/adobeupload.php");
		private var _URLrequest:URLRequest;
		private var _imageTypes:FileFilter = new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png");
		private var _textTypes:FileFilter = new FileFilter("Text Files (*.txt, *.rtf)", "*.txt; *.rtf");
		private var _allTypes:Array = new Array(_imageTypes, _textTypes);
		private var _fileRef:FileReference;
		private var _userPath:String;
		private var _serverPath:String;
		private var _fullPathPHP:String;
		
		
		public function FileUpload()
        {
			trace("**** FILEUPLOAD() ****");
		}
		
		// Function that fires off when the user presses "browse for a file"
		
		public function browseForUpload():void 
		{
			_fileRef = new FileReference();
			_fileRef.addEventListener(Event.SELECT, syncVariables);
			_fileRef.addEventListener(Event.COMPLETE, completeHandler);
			_fileRef.addEventListener(Event.CANCEL, cancelHandler);
			_fileRef.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_fileRef.browse(_allTypes);
		}
			
		/*private function browseBox(event:MouseEvent):void 
		{
			_fileRef.browse(_allTypes);
		}
		*/
		
		// After user has selected a file it is displayed, this clears that text
		public function clearFileDisplay():void
		{
			fileDisplay_txt.text = "";
		}
		
		public function setPaths(spath:String, upath:String):void
		{
			_userPath = upath;
			_serverPath = spath;
			_fullPathPHP = _serverPath + "uploader_script.php";
			//var fullPathPHP:String = _serverPath + _userPath + "adobeupload.php"
			trace("XXXXXXXXXXX fileUpload/setPaths/_fullPathPHP: "+ _fullPathPHP);
			//_URLrequest = new URLRequest(_fullPathPHP);	
		}
		
		// Function that fires off when the user presses the "upload it now" btn
		public function uploadFile():void 
		{
			//uploadMsg.visible = true;
			_fileRef.upload(_URLrequest);
			trace("uploadfile >>>>>>>>>>>>>>>>  "+ _fileRef.name + " <<<<<<<<<<<<<<<<");
			dispatchEvent(new TryUploadEvent(TryUploadEvent.TRYUPLOAD, {name : _fileRef.name}));
			//upload_btn.visible = false;
		}
		// Function that fires off when File is selected  from PC and Browse dialogue box closes
		private function syncVariables(event:Event):void 
		{
			fileDisplay_txt.text = "" + _fileRef.name;
			trace("sync >>>>>>>>>>>>>>>> name: "+ _fileRef.name + " <<<<<<<<<<<<<<<<");
			trace("sync >>>>>>>>>>>>>>>> size: "+ _fileRef.size + " <<<<<<<<<<<<<<<<");
			 //upload_btn.visible = true;
			 //progressBar.width = 2;
		    var variables:URLVariables = new URLVariables();
		    variables.todayDate = new Date();
		    trace("sync >>>>>>>>>>>>>>>>  A <<<<<<<<<<<<<<<<");
		    variables.Name = "dDiggs"; // This could be an input field variable like in my contact form tutorial : )
			variables.Email = "info@flashturnaround.com"; // This one the same
			_URLrequest = new URLRequest(_fullPathPHP);
			trace("sync >>>>>>>>>>>>>>>>  B <<<<<<<<<<<<<<<<");
		    _URLrequest.method = URLRequestMethod.POST;
		    trace("sync >>>>>>>>>>>>>>>>  B2 <<<<<<<<<<<<<<<<");
		    _URLrequest.data = variables;
		    trace("sync >>>>>>>>>>>>>>>>  C <<<<<<<<<<<<<<<<");
			var filesize:Number = Math.round(_fileRef.size / 1024);
			var data:Object = new Object();
			data.name = _fileRef.name;
			data.size = filesize;
			data.type = _fileRef.type;
			//dispatchEvent(new CustomEvent("passUploadData", {name:"test"}));
			//dispatchEvent(new TryUploadEvent(TryUploadEvent.PASSDATA, {name :"user"}));
			dispatchEvent(new TryUploadEvent(TryUploadEvent.PASSDATA, data));
			trace("sync >>>>>>>>>>>>>>>>  FINISHED <<<<<<<<<<<<<<<<");
		}
		
		//fires if user hits 'cancel' button during file browse
		private function cancelHandler(event:Event):void 
		{
			trace("cancelHandler: " + event);
			fileDisplay_txt.text = "";
			dispatchEvent(new TryUploadEvent(TryUploadEvent.CANCELUPLOAD, {name :"user"}));
		}
		
		// Function that Should but doesn't fire off when upload is complete
		private function completeHandler(event:Event):void 
		{
			//
		}
		
		// Function that should but doesn't fire off when the upload progress begins
		private function progressHandler(event:ProgressEvent):void 
		{
		   // change 200 to complete width
			var tmpStat:Number = Math.ceil(100*(event.bytesLoaded/event.bytesTotal));
			//status_txt.text = tmpStat.toString();
		    //progressBar.width = Math.ceil(200*(event.bytesLoaded/event.bytesTotal));
			
		}
	}
}


