package com.popchan.display.component
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 *
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class HScrollBar extends ScrollBar
	{
		public function HScrollBar(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0, direction:String=SliderDirection.VERTICAL, skinName:String="Skin_scrollbar")
		{
			super(parent, x, y, SliderDirection.HORIZONTAL, skinName);
		}
	}
}