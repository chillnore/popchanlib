package com.popchan.display.ui
{
	import flash.events.Event;
	
	/**
	 *组件事件
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class ComponentEvent extends Event
	{
		/**
		 *按钮持续按下 
		 */
		public static const BUTTON_DOWN:String="buttonDown";
		/**
		 *文本等按下enter键 
		 */
		public static const ENTER:String="enter";
		public function ComponentEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}