package com.popchan.display.bitmap
{
	import flash.display.BitmapData;
	/**
	 *每帧的信息
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class BitmapFrameInfo
	{
		/**
		 *位图数据 
		 */
		public var bitmapData:BitmapData;
		/**
		 *偏移量X 
		 */
		public var offsetX:Number=0;
		/**
		 *偏移量Y 
		 */
		public var offsetY:Number=0;
		/**
		 *标签信息 比如mc转化为位图序列帧的时候可记录 
		 */
		public var label:String;
	}
}