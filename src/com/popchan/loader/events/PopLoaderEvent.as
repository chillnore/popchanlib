package com.popchan.loader.events
{
	import com.popchan.loader.handlers.LoaderBase;
	
	import flash.events.Event;

	/**
	 *加载事件
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class PopLoaderEvent extends Event
	{
		public var bytesLoaded:int;
		public var bytesTotal:int;
		public var loader:LoaderBase;
		public var fileLoaded:int;
		public var fileTotal:int;
		
		/**所有文件加载完毕*/
		public static const COMPLETE:String="complete";
		/**加载进度*/
		public static const PROGRESS:String="progress";
		/**单个文件加载完毕*/
		public static const SINGLE_FILE_LOADED:String="single_file_loaded";
		public static const ERROR:String="error";
		public static const ABORT:String="abort";
		public static const SECURITY_ERROR:String="security_error";
		public function PopLoaderEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		public function setProgressInfo(fileLoaded:int,fileTotal:int):void
		{
			this.fileLoaded=fileLoaded;
			this.fileTotal=fileTotal;
		}
	}
}