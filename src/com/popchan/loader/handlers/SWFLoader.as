package com.popchan.loader.handlers
{
	/**
	 *swf文件加载
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class SWFLoader extends ImageLoader
	{
		public function SWFLoader(url:String, type:String=null)
		{
			super(url, type);
		}
		/**
		 *获取类文件 
		 * @param className
		 * @return 
		 * 
		 */
		public function getDefinitionByName(className : String) : Object
		{
			if (_loader.contentLoaderInfo.applicationDomain.hasDefinition(className))
			{
				return _loader.contentLoaderInfo.applicationDomain.getDefinition(className);
			}
			return null;
		}
	}
}