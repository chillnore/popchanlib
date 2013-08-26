package com.popchan.debug
{
	import flash.events.EventDispatcher;

	/**
	 *简单debug工具
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class Log
	{
		public function Log()
		{
		}
		public static function info(value:String):void
		{
			trace("[info] "+value);
		}
		public static function error(value:String):void
		{
			trace("[error] "+value);
		}
	}
}