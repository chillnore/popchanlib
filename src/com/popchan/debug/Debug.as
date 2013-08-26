package com.popchan.debug
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 *简单调试支持本地和浏览器输出
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class Debug
	{
		private static var container:Sprite;
		private static var txt:TextField;
		public static function initParent(parent:DisplayObjectContainer,xpos:Number=0,ypos:Number=0):void
		{
			container=new Sprite();
			container.x=xpos;
			container.y=ypos;
			parent.addChild(container);
			
			txt=new TextField();
			txt.defaultTextFormat=new TextFormat(null,14);
			txt.background=true;
			txt.backgroundColor=0x292929;
			txt.border=true;
			txt.borderColor=0x0;
			txt.width=200;
			txt.height=200;
			txt.wordWrap=true;
			txt.multiline=true;
			container.addChild(txt);
		}
		public static function colorStr(value:String,color:String):String
		{
			value="<font color='"+color+"'>"+value+"</font>\n";
			return value;
		}
		public static function info(...arg):void
		{
			if(txt)txt.htmlText+=colorStr("【info】"+arg.toString(),"#00ff00");;
			trace("[info] "+arg.toString());
		}
		public static function log(...arg):void
		{
			if(txt)txt.htmlText+=colorStr("【log】"+arg.toString(),"#0000ff");
			trace("[log] "+arg.toString());
		}
		public static function error(...arg):void
		{
			if(txt)txt.htmlText+=colorStr("【error】"+arg.toString(),"#ff0000");;
			trace("[error] "+arg.toString());
		}
		public static function warning(...arg):void
		{
			if(txt)txt.htmlText+=colorStr("【warning】"+arg.toString(),"#ffff00");;	
			trace("[warn] "+arg.toString());
		}
		
		public static function debugToBrowser(...args):void
		{
			if(Capabilities.playerType!="StandAlone")
			{
				ExternalInterface.call("console.debug",args);
			}
		}
		public static function infoToBrowser(...args):void
		{
			if(Capabilities.playerType!="StandAlone")
			{
				ExternalInterface.call("console.info",args);
			}
		}
		public static function warnToBrowser(...args):void
		{
			if(Capabilities.playerType!="StandAlone")
			{
				ExternalInterface.call("console.warn",args);
			}
		}
		public static function errorToBrowser(...args):void
		{
			if(Capabilities.playerType!="StandAlone")
			{
				ExternalInterface.call("console.error",args);
			}
		}
	}
}