package com.popchan.loader.handlers
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;

	/**
	 *二进制文件加载
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class BinaryLoader extends LoaderBase
	{
		protected var _urlLoader:URLLoader;
		protected var _dataFormat:String;
		public function BinaryLoader(url:String, type:String=null)
		{
			super(url, type);
			_dataFormat=URLLoaderDataFormat.BINARY;
			
		}
		override public function load():void
		{
			super.load();
			_urlLoader=new URLLoader();
			addListerner(_urlLoader);
			_urlLoader.dataFormat=_dataFormat;
			_urlLoader.load(_urlRequest);
		}
		
		override protected function loadedHandler():void
		{
			_size=_urlLoader.bytesLoaded;
			_content=_urlLoader.data;
		}
	}
}