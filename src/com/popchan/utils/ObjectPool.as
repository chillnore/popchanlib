package com.popchan.utils
{
	import flash.utils.Dictionary;

	/**
	 *对象池工具
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class ObjectPool
	{
		private static var pool:Dictionary=new Dictionary();
		private var list:Array=[];
		private var cl:Class;
		public function ObjectPool(value:Class)
		{
			this.cl=value;
		}
		/**
		 *获取对象 
		 * @return 
		 * 
		 */
		public function getObject():Object
		{
			if(list.length>0)
				return list.shift();
			return new cl();
		}
		/**
		 *回归对象 
		 * @param obj
		 * 
		 */
		public function returnObject(obj:Object):void
		{
			list.push(obj);
		}
		/**
		 *获取对象池 
		 * @param className
		 * @return 
		 * 
		 */
		static public function getPool(value:Class):ObjectPool
		{
			if(!pool[value])
			{
				pool[value]=new ObjectPool(value);
			}
			return pool[value];
		}
	}
}