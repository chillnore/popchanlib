package com.popchan.loader.handlers
{
	import com.popchan.debug.Debug;
	import com.popchan.loader.core.LoaderType;
	
	import flash.display.Loader;
	import flash.events.Event;
	
	/**
	 *图片加载器
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class ImageLoader extends LoaderBase
	{
		protected var _loader:Loader;
		public function ImageLoader(url:String,type:String=LoaderType.IMAGE)
		{
			super(url,type);
		}
		override public function load():void
		{
			super.load();
			_loader=new Loader();
			addListerner(_loader.contentLoaderInfo);
			_loader.load(_urlRequest);
		}
		
		override public function close():void
		{
			try
			{
				_loader.close();
			}catch(e:Error)
			{
				
			};
		}
		override public function dispose():void
		{
			close();
			removeListener(_loader.contentLoaderInfo);
			super.dispose();
			_loader=null;
		}
		
		override protected function loadedHandler():void
		{
			_size=_loader.contentLoaderInfo.bytesLoaded;
			_content=_loader.contentLoaderInfo.content;
		}
		
		
	}
}