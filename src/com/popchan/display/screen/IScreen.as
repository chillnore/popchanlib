package com.popchan.display.screen
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 *屏幕管理接口
	 *Version 1.0
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public interface IScreen
	{
		function set skin(value:DisplayObject):void;
		/**
		 *皮肤 显示内容 
		 * @return 
		 * 
		 */
		function get skin():DisplayObject;
		function set data(value:Object):void;
		/**
		 *设置数据 
		 * @return 
		 * 
		 */
		function get data():Object;
		function set callBack(value:Function):void;
		/**
		 *回调函数 
		 * @return 
		 * 
		 */
		function get callBack():Function;
		function set parentContainer(value:Layer):void;
		/**
		 *父容器 
		 * @return 
		 * 
		 */
		function get parentContainer():Layer;
		/**
		 *关闭 
		 * 
		 */
		function close():void;
	}
}