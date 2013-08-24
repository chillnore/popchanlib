package com.popchan.manager
{
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	
	/**
	 *本地存储管理
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class LocalManager extends EventDispatcher
	{
		private static var _instance:LocalManager;
		private var _so:SharedObject;
		private var _minDiskSpace:int =0;
		public function LocalManager()
		{
			try
			{
				_so=SharedObject.getLocal("com.popchan.manager.localManager");
			}catch(e:Error)
			{
				trace("LocalManager Error:"+e.message);
			}
		}
		/**
		 *存储数据 
		 * @param key
		 * @param value
		 * 
		 */
		public function save(key:String,value:Object):void
		{
			var status:String;
			_so.data[key]=value;
			try
			{
				status = _so.flush(_minDiskSpace);
			}
			catch (e:Error)
			{
				trace("不能写入磁盘")
			}
			
			if (status != null)
			{
				switch (status)
				{
					case SharedObjectFlushStatus.PENDING:
						_so.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
						trace("弹出是否运行存储到本地对话框");
						break;
					case SharedObjectFlushStatus.FLUSHED:
						trace("成功写入本地磁盘");
						break;
				}
			}
		}
		/**
		 *获取值 
		 * @param key
		 * @return 
		 * 
		 */
		public function getValue(key:String):Object
		{
			return _so.data[key];	
		}
		/**
		 *清除保存到本地的数据 
		 * 
		 */
		public function clear():void
		{
			_so.clear();
		}
		/**
		 *共享对象的当前大小 
		 * @return 
		 * 
		 */
		public function get size():uint
		{
			return _so.size;
		}
		
		protected function onFlushStatus(event:NetStatusEvent):void
		{
			_so.removeEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
			switch (event.info.code)
			{
				
				case "SharedObject.Flush.Success":
					trace("用户允许写入数据到本地磁盘");
					break;
				case "SharedObject.Flush.Failed":
					trace("用户禁止写入数据到本地磁盘");
					break;
			}
		}
		public static function get instance():LocalManager
		{
			if(_instance==null)
				_instance=new LocalManager();
			return _instance;
		}
		/**
		 * 最小磁盘空间
		 * @return 
		 * 
		 */
		public function get minDiskSpace():int
		{
			return _minDiskSpace;
		}

		/**
		 * @private
		 */
		public function set minDiskSpace(value:int):void
		{
			_minDiskSpace = value;
		}
		
	}
}