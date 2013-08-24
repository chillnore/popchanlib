package com.popchan.utils
{
	/**
	 *字符串工具
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class StringUtil
	{
		/**
		 *替换字符串某部分的值为新的值
		 * eg.  var str:String="{0}年{1}月{2}日";
		 * 		var new:String=substitute(str,2012,12,20);
		 * 		trace(str);
		 * 		 2012年12月20日 
		 * @param target
		 * @param rest
		 * @return 
		 * 
		 */
		public static function substitute(target:String,...rest):String
		{
			if(target==null)return null;
			var len:int=rest.length;
			for(var i:int=0;i<len;i++)
			{
				target = target.replace(new RegExp("\\{"+i+"\\}", "g"), rest[i]);
			}
			return target;
		}
		/**
		 * 过滤目标字符串首尾的空白字符
		 * @param target
		 * 
		 */
		public static function trim(target:String):String
		{
			if (target == null) return '';
			
			var startIndex:int = 0;
			while (isWhitespace(target.charAt(startIndex)))
				++startIndex;
			
			var endIndex:int = target.length - 1;
			while (isWhitespace(target.charAt(endIndex)))
				--endIndex;
			
			if (endIndex >= startIndex)
				return target.slice(startIndex, endIndex + 1);
			else
				return "";
		}
		/**
		 *是否是空白字符 
		 * @param char
		 * @return 
		 * 
		 */
		public static function isWhitespace(char:String):Boolean
		{
			if(char==" "||char=="\t"||char=="\r"||char=="\n"||char=="\f")
				return true;
			return false;
		}
		/**
		 *将目标字符串转换为Html比如[font color='#000000']xxx[/font]----------<font color='#000000'>xxx</font> 
		 * @param str
		 * @return 
		 * 
		 */
		public static  function convertStrToHtml(target:String):String
		{
			var ExpStar:RegExp = /\[/g;
			var ExpEnd:RegExp =/\]/g;
			target = target.replace(ExpStar,"<");
			target = target.replace(ExpEnd,">");
			return target;
		}
	}
}