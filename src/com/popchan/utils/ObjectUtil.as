package com.popchan.utils
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 *对象工具
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class ObjectUtil
	{
		/**
		 *检测一个对象是否为空 
		 * @param obj
		 * @return 
		 * 
		 */
		public static function isEmpty(obj:*):Boolean
		{
			if (obj == undefined) return true;
			if (obj is Number) return isNaN(obj);
			if (obj is Array) return (obj as Array).length == 0;
			if (obj is String) return (obj as String).length == 0;
			
			if (obj is Object)
			{
				for (var p:String in obj)
				{
					return false;
				}
				return true;
			}
			
			return false;
		}
		/**
		 *获取Object的Key 
		 * @param obj
		 * @return 
		 * 
		 */
		public static function getKeys(obj:Object):Vector.<String>
		{
			var keys:Vector.<String> = new Vector.<String>();
			for (var k:String in obj)
			{
				keys.push(k);
			}
			return keys;
		}
		/**
		 *克隆一个对象 
		 * @param source
		 * @return 
		 * 
		 */
		public static function baseClone(source:*):*
		{
			var typeName:String = getQualifiedClassName(source);
			var packageName:String = typeName.split("::")[1];
			var type:Class = Class(getDefinitionByName(typeName));
			
			registerClassAlias(packageName, type);
			
			var copier:ByteArray = new ByteArray();
			copier.writeObject(source);
			copier.position = 0;
			return copier.readObject();
		}
		/**
		 *得到 displayObject的区域 解决多次设置displayObject.scrollRect后displayObject的宽高变成了scrollRect中设置的宽高问题
		 * @param displayObject
		 * @return 
		 * 
		 */
		static public  function getFullBounds(displayObject:DisplayObject):Rectangle
		{
			var bounds:Rectangle;
			var transform:Transform=displayObject.transform;
			var toGlobalMatrix:Matrix;
			var currentMatrix:Matrix;
			
			currentMatrix=transform.matrix;
			toGlobalMatrix=transform.concatenatedMatrix;
			toGlobalMatrix.invert();
			transform.matrix=toGlobalMatrix;
			bounds=transform.pixelBounds.clone();
			transform.matrix=currentMatrix;
			return bounds;
		}
	}
}