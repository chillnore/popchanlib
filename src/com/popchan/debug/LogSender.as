package com.popchan.debug
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	/**
	 *用localconnection发送消息  
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class LogSender extends EventDispatcher
	{
		private var conn:LocalConnection;
		private static const CONNECTNAME:String="logConnection";
		private static var _instance:LogSender=new LogSender();
		public function LogSender()
		{
			conn=new LocalConnection();
			conn.addEventListener(StatusEvent.STATUS, onStatus);
		}
		public function send(name:String,handler:String,data:Object):void
		{
			conn.send(name,handler,data);
		}
		
		/**
		 *输出 
		 * @param data
		 * 
		 */
		public static function debug(data:Object):void
		{
			_instance.send(CONNECTNAME,"debug",data);
		}
		/**
		 *警告
		 * @param data
		 * 
		 */
		public static function warn(data:Object):void
		{
			_instance.send(CONNECTNAME,"warn",data);
		}
		/**
		 *错误
		 * @param data
		 * 
		 */
		public static function error(data:Object):void
		{
			_instance.send(CONNECTNAME,"error",data);
		}
		
		private function onStatus(event:StatusEvent):void {
			switch (event.level) {
				case "status":
					//trace("LocalConnection.send() succeeded");
					break;
				case "error":
					trace("LocalConnection.send() failed");
					break;
			}
		}

	}
}