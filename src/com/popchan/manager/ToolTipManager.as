package com.popchan.manager
{
	
	import com.popchan.display.component.ToolTip;
	
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	/**
	 *提示管理
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class ToolTipManager extends Sprite
	{
		/*需要的提示类*/
		private static var _instance:ToolTip;
		/*存放taraget数据*/
		private static var _targetDict:Dictionary=new Dictionary(true);
		/*整个toolTip的父容器*/
		private static var _parentContainer:DisplayObjectContainer;
		
		public static var toolTipClass:Class=ToolTip;

		public function ToolTipManager()
		{
			
		}
		/**
		 *初始化 设置
		 * @param parent
		 * 
		 */
		public static function init(parent:DisplayObjectContainer):void
		{
			_parentContainer=parent;
			getInstance();
			
		}
		public static function getInstance():ToolTip
		{
			if(_instance==null)
				_instance=new toolTipClass(_parentContainer);
			return _instance;
		}
		/**
		 *给DisplayObject注册一个tip 
		 * @param target
		 * @param data 要显示的数据
		 * 
		 */
		public static function register(target:DisplayObject,data:Object):void
		{
			unRegister(target);
			_targetDict[target]=data;
			
			_instance.visible=false;
		
			target.addEventListener(MouseEvent.ROLL_OVER,onTipOver);	
			target.addEventListener(MouseEvent.MOUSE_MOVE,onTipMove);	
			target.addEventListener(MouseEvent.ROLL_OUT,onTipOut);	
		}
		/**
		 *取消注册 
		 * @param target
		 * 
		 */
		public static function unRegister(target:DisplayObject):void
		{
			if(_targetDict[target])
			{
				delete _targetDict[target];
				target.removeEventListener(MouseEvent.ROLL_OUT,onTipOut);	
				target.removeEventListener(MouseEvent.ROLL_OVER,onTipOver);	
				target.removeEventListener(MouseEvent.MOUSE_MOVE,onTipMove);
			}
		}
		
		protected static function onTipMove(event:MouseEvent):void
		{
			var target:DisplayObject=event.currentTarget as DisplayObject;
			_instance.x=_instance.parent.mouseX+15;
			_instance.y=_instance.parent.mouseY;
			_instance.data=_targetDict[target];
			_instance.setLocation();
		}
		
		protected static function onTipOver(event:MouseEvent):void
		{
			var target:DisplayObject=event.currentTarget as DisplayObject;
			_instance.x=_instance.parent.mouseX+15;
			_instance.y=_instance.parent.mouseY;
			_instance.data=_targetDict[target];
			_instance.visible=true;
			_instance.setLocation();
			
			
		}
		
		protected static function onTipOut(event:MouseEvent):void
		{
			var target:DisplayObject=event.currentTarget as DisplayObject;
			_instance.destory();
			_instance.visible=false;
		}
	}
}