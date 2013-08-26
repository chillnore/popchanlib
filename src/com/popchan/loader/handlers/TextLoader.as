package com.popchan.loader.handlers
{
	import flash.net.URLLoaderDataFormat;

	/**
	 *文本加载器
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class TextLoader extends BinaryLoader
	{
		public function TextLoader(url:String, type:String=null)
		{
			super(url, type);
			_dataFormat=URLLoaderDataFormat.TEXT;
		}
	}
}