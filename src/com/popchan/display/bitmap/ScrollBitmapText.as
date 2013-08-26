package com.popchan.display.bitmap
{
	import flash.display.BitmapData;
	
	/**
	 *数字可滚动变化的位图文本
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class ScrollBitmapText extends BitmapText
	{
		public function ScrollBitmapText(source:BitmapData, titleWidth:int, titleHeight:int, offset:int=0, queue:String="0123456789")
		{
			super(source, titleWidth, titleHeight, offset, queue);
		}
		/**
		 *滚动 
		 * @param fromValue 开始value
		 * @param toValue  结束value
		 * @param time  滚动持续时间
		 * @param delay 延迟多少秒滚动
		 * @param onCompleteFun 滚动完毕回调函数
		 * @param onUpdateFun 滚动更新函数
		 * 
		 */
		public function scroll(fromValue:int,toValue:int,time:Number=1,delay:Number=0,onCompleteFun:Function=null,onUpdateFun:Function=null):void
		{
			
			var obj:Object={value:fromValue};
			
			/*twe.to(obj,time,{value:toValue,delay:delay,
				onUpdate:function():void
				{
					text=int(obj.value).toString();
					if(onUpdateFun!=null)
					{
						onUpdateFun();
					}
				},
				onComplete:function():void
				{
					if(onCompleteFun != null)
					{
						onCompleteFun.call();
					}
				}
			});*/
		}
	}
}