package com.popchan.utils
{
	/**
	 *时间格式化工具
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class TimeUtil
	{
		/**
		 *格式化时间 返回 10:08:59
		 * @param seconds 秒
		 * @return 
		 * 
		 */
		public static function formatTime(seconds:int):String
		{
			var h:int=seconds/3600;
			var m:int=seconds%3600/60;
			var s:int=seconds%60;
			return addZero(h)+":"+addZero(m)+":"+addZero(s);
		}
		/**
		 * 补0操作，比如9 变成09
		 * @param value
		 * @return 
		 * 
		 */
		public static function addZero(value:int):String
		{
			return (value>9)?value.toString():("0"+value);	
		}
			
	}
}