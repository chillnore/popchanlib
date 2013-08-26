package com.popchan.display.component
{
	/**
	 *tooltip接口
	 *Version 1.0
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public interface IToolTip
	{
		function set data(value:Object):void;
		function get data():Object;
		/**
		 *设置位置
		 * 
		 */
		function setLocation():void;
		/**
		 *当需要清除的时候用 
		 * 
		 */
		function destory():void;
	}
}