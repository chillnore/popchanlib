package com.popchan.manager
{
	import com.popchan.utils.BitmapUtil;
	
	import flash.display.BitmapData;
	import flash.system.ApplicationDomain;

	/**
	 *资源管理，缓存等
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class ResourceManager
	{
		public static var cacheClips:Object={};
		public static var cacheBitmapData:Object={};
		/**
		 *获取位图剪辑 
		 * @param name
		 * @param rowCount
		 * @param colCount
		 * @return 
		 * 
		 */
		public  static function getBitmapClips(name:String,rowCount:int,colCount:int):Array
		{
			if(cacheClips[name]==null)
			{
				var bmd:BitmapData=getBitmapData(name);
				var arr:Array=BitmapUtil.trimBmd(bmd,rowCount,colCount);
				cacheClips[name]=arr;
			}
			return cacheClips[name];
		}
		/**
		 *从当前域获取位图 
		 * @param name
		 * @return 
		 * 
		 */
		public static function getBitmapData(name:String):BitmapData
		{
			if(cacheBitmapData[name]!=null)
				return cacheBitmapData[name];
			if(ApplicationDomain.currentDomain.hasDefinition(name))
			{
				var Res:Class=ApplicationDomain.currentDomain.getDefinition(name) as Class;
				var bmd:BitmapData=new Res(0,0);
				cacheBitmapData[name]=bmd;
				return bmd;
			}
			return null;
		}
		
		
	}
}