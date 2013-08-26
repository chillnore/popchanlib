package com.popchan.manager
{
	import com.popchan.debug.Debug;

	/**
	 *消息通讯 抛弃flash自带事件，改用回调
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class MessageManager
	{
		private static var _list:Object={};
		public function MessageManager()
		{
			
		}
		/**
		 *注册消息号和对应的处理函数 
		 * @param message
		 * @param func
		 * 
		 */
		public static function registerMessage(message:String,func:Function):void
		{
			if(_list[message]==null)
			{
				_list[message]=[];
			}
			_list[message].push(func);
			
		}
		/**
		 *发送消息 
		 * @param message
		 * @param args
		 * 
		 */
		public static function dispatchMessage(message:String,...args):void
		{
			if(_list[message]==null)
			{
				Debug.error("未注册名称为"+message+"的消息");
				return;
			}
			
			for(var mes:String in _list)
			{
				if(mes==message)
				{
					var array:Array=_list[mes] as Array;
					for each(var obj:Object in array)
					{
						(obj as Function).apply(null,args);
					}
					break;
				}
			}
		}
		/**
		 *移出消息 
		 * @param message
		 * 
		 */
		public static function removeMessage(message:String):void
		{
			for(var mes:String in _list)
			{
				if(mes==message)
				{
					var array:Array=_list[mes] as Array;
					for(var obj:Object in array)
					{
						delete array[obj];
					}
					delete _list[mes];
					break;
				}
			}
		}
	}
}