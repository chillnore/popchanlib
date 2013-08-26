package com.popchan.display.ui
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 *线框 类似ps图片编辑时候周围的8个控制点
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class Wireframe extends Sprite
	{
		public function Wireframe()
		{
			super();
		}
		/**
		 *设置源，在其周围生成控制点 
		 * @param target
		 * 
		 */
		public function setSource(target:DisplayObject):void
		{
			var rect:Rectangle=target.getRect(target);
			var line:Shape=new Shape();
			line.graphics.lineStyle(1);
			line.graphics.drawRect(rect.x,rect.y,target.width,target.height);
			this.addChild(line);
			this.x=target.x;
			this.y=target.y;
		}
	}
}