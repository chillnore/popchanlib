package com.popchan.manager
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 *提示管理
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class ToolTipManager extends Sprite
	{
		public function ToolTipManager()
		{
			super();
		}
		/**
		 *初始化 
		 * @param parent
		 * 
		 */
		public static function init(parent:DisplayObjectContainer):void
		{
			
		}
		public static function register(target:DisplayObject,showDelay:int=0):void
		{
			target.addEventListener(MouseEvent.ROLL_OUT,onTipOut);	
			target.addEventListener(MouseEvent.ROLL_OVER,onTipOver);	
		}
		
		protected static function onTipOver(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected static function onTipOut(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
	}
}