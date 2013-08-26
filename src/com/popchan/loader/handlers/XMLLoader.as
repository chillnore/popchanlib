package com.popchan.loader.handlers
{
	import flash.events.Event;

	/**
	 *xml加载器
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class XMLLoader extends TextLoader
	{
		public function XMLLoader(url:String, type:String=null)
		{
			super(url, type);
		}
		override protected function onLoaded(e:Event):void
		{
			_size=_urlLoader.bytesLoaded;
			_content=new XML(_urlLoader.data);
			super.onLoaded(e);
		}
		override protected function loadedHandler():void
		{
			_size=_urlLoader.bytesLoaded;
			_content=new XML(_urlLoader.data);
		}
		
	}
}