package com.popchan.display.component
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 *容器基类
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class Box extends Component
	{
		public function Box(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}
		override public function addChild(child:DisplayObject):DisplayObject
		{
			super.addChild(child);
			invalidate(CallLaterEnum.SIZE);
			return child;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			super.addChildAt(child, index);
			invalidate(CallLaterEnum.SIZE);
			return child;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			super.removeChild(child);
			invalidate(CallLaterEnum.SIZE);
			return child;
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject=super.removeChildAt(index);
			invalidate(CallLaterEnum.SIZE);
			return child;
		}
		override protected function draw():void
		{
			if(isCallLater(CallLaterEnum.SIZE))
			{
				layout();
			}
			clearCallLater();
		}
		
		/**
		 *布局 
		 * 
		 */
		protected function layout():void
		{
			
		}
	}
}