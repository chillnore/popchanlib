package com.popchan.utils
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	/**
	 *获取swf中的所有类并且载入到当前域 
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class SwfUtil extends EventDispatcher
	{
		public var fileName:String="";
		public var list:Array;
		private var loader:Loader;
		public var classObj:Object={};
		public function SwfUtil(target:IEventDispatcher=null)
		{
			loader=new Loader();
			
		}
		
		protected function onOk(event:Event):void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onOk);
			
			
			for(var i:int=0;i<list.length;i++)
			{
				var Res:Class=getClass(list[i]);
				if(Res)
				{
					classObj[list[i]]=Res;
				}
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		public function read(by:ByteArray):void
		{
			
			var loaderContext:LoaderContext=new LoaderContext(false,ApplicationDomain.currentDomain);
			loaderContext.allowLoadBytesCodeExecution=true;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onOk);
			loader.loadBytes(by,loaderContext);
			
			list=SwfFileRead.getAllClassName(by);
			
		}
		public function getClass(name:String):Class
		{
			try
			{
				var ref:Class = loader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
			}
			catch (e:Error)
			{
				
			}
			return ref;
		}
	}
}