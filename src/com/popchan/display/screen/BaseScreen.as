package com.popchan.display.screen
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 *屏幕基类 当抽象类来处理，其他类需继承它
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class BaseScreen extends Sprite implements IScreen
	{
		protected var _skin:DisplayObject;
		protected var _data:Object;
		protected var _parentContainer:Layer;
		protected var _callBack:Function;
		public function BaseScreen()
		{
			super();
		}
		
		public function set skin(value:DisplayObject):void
		{
			_skin=value;
		}
		
		public function get skin():DisplayObject
		{
			return _skin;
		}
		public function set data(value:Object):void
		{
			_data=value;
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set callBack(value:Function):void
		{
			_callBack=value;
		}
		
		public function get callBack():Function
		{
			return _callBack;
		}
		
		public function set parentContainer(value:Layer):void
		{
			_parentContainer=value;
		}
		
		public function get parentContainer():Layer
		{
			return _parentContainer;
		}
		
		public function close():void
		{
			ScreenManager.removeDialog(this);
		}
	}
}