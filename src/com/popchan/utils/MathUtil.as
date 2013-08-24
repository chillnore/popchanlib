package com.popchan.utils
{
	/**
	 *数字工具
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class MathUtil
	{

		/**
		 *是否是奇数 
		 * @param value
		 * @return 
		 * 
		 */
		public static function isEven(value:Number):Boolean 
		{
			return (value & 1) == 0;
		}
		/**
		 *是否是偶数 
		 * @param value
		 * @return 
		 * 
		 */
		public static function isOdd(value:Number):Boolean 
		{
			return !isEven(value);
		}
	}
}