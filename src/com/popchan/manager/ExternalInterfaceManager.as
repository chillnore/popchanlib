package com.popchan.manager
{
	import flash.external.ExternalInterface;

	/**
	 *与JS通讯管理
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class ExternalInterfaceManager
	{
		[Embed(source = "External.js",mimeType="application/octet-stream")]
		private static var js:Class;
		private static var _instance:ExternalInterfaceManager;
		public function ExternalInterfaceManager()
		{
			if(ExternalInterface.available)
			{
				ExternalInterface.call("eval",new js().toString());
			}
		}
		public static function get instance():ExternalInterfaceManager
		{
			if(_instance==null)
				_instance=new ExternalInterfaceManager;
			return _instance;
		}
		/**
		 *获取Url 
		 * @return 
		 * 
		 */
		public function get url():String
		{
			return ExternalInterface.call("getUrl");
		}
		/**
		 *获取标题 
		 * @return 
		 * 
		 */
		public function get title():String
		{
			return ExternalInterface.call("getTitle");
		}
		/**
		 * 加入收藏夹 
		 * @param url
		 * @param title
		 * 
		 */        
		public function addFavorite(title:String=null,url:String=null):void
		{
			if (!title)
				title = this.title;
			if (!url)
				url = this.url;
			ExternalInterface.call("addFavorite",url,title);
		}
		/**
		 * 设为主页
		 * @param url
		 * 
		 */        
		public function setHomePage(url:String=null):void
		{
			if (!url)
				url = this.url;
			ExternalInterface.call("setHomePage",url);
		}
		/**
		 * 设置cookie
		 * 
		 * @param name           cookie名称
		 * @param value          cookie值
		 * @param expires        cookie过期时间
		 * @param security       是否加密
		 */
		public function setCookie(name:String, value:String, expires:Date=null, security:Boolean=false):void
		{
			expires || (expires = new Date(new Date().time + (1000 * 86400 * 365)));
			ExternalInterface.call("setCookie",name,value,expires.time,security);
		}
		
		/**
		 * 读取cookie
		 * 
		 * @param name	cookie名称
		 * @return 
		 * 
		 */        
		public function getCookie(name:String):String
		{
			return ExternalInterface.call("getCookie",name);
		}
		
		/**
		 * 在浏览器关闭时提供确认提示
		 * 
		 */
		public function confirmClose(text:String = "确认退出？"):void
		{
			if (text)
				ExternalInterface.call("confirmClose",text);
			else
				ExternalInterface.call("confirmClose");
		}
		
		/**
		 * 弹出警示框
		 * @param text
		 * 
		 */
		public function alert(...params):void
		{
			ExternalInterface.call("alert",params.toString());
		}
		
		/**
		 * 刷新浏览器 
		 * 
		 */
		public function reload():void
		{
			ExternalInterface.call("location.reload");
		}
		
		/**
		 * 消除浏览器的滚动事件干扰 
		 * 
		 */
		public function disableScroll(objId:String = null):void
		{
			ExternalInterface.call("disableScroll",objId);
		}
	}
}