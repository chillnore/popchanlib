package com.popchan.utils
{
	import flash.net.LocalConnection;

	/**
	 *内存工具
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class MemoryUtil
	{
		/**
		 *强制回收 
		 * 
		 */
		public static function gc():void
		{
			try
			{
				new LocalConnection().connect("a.b.c");
				new LocalConnection().connect("a.b.c");
			}catch(e:Error)
			{
				
			}
		}
	}
}