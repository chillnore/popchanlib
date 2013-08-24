package com.popchan.utils
{
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;

	/**
	 *滤镜工具
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class FilterUtil
	{
		public static var grayFilter:ColorMatrixFilter=new ColorMatrixFilter([0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0, 0, 0, 1, 0]); //灰白
		/**
		 *给对象添加滤镜 
		 * @param target
		 * @param filter
		 * 
		 */
		public static function addFilter(target:DisplayObject,filter:BitmapFilter):void
		{
			var filters:Array=(target.filters==null)?[]:target.filters;
			filters.push(filter);
			target.filters=filters;
		}
		/**
		 *移出对象的滤镜 
		 * @param target
		 * @param filterClass
		 * 
		 */
		public static function removeFilter(target:DisplayObject,filterClass:Class):void
		{
			var filters:Array=target.filters;
			if(filters!=null&&filters.length>0)
			{
				for(var i:int=filters.length-1;i>=0;i--)
				{
					if(filters[i] is filterClass)
					{
						filters.splice(i,1);
					}
				}
			}
			target.filters=filters;
		}
		/**
		 *让对象变灰 
		 * @param target
		 * @param value
		 * 
		 */
		public static function gray(target:DisplayObject,value:Boolean):void
		{
			target.filters=value?[grayFilter]:null;
		}
		/**
		 *描边 
		 * @param target
		 * @param blurX
		 * @param blurY
		 * @param strength
		 * @param alpha
		 * 
		 */
		public static function stroke(target:DisplayObject,color:uint=0x000000,blurX:Number=3,blurY:Number=3,strength:int=1,alpha:Number=1):void
		{
			var filters:Array=(target.filters==null)?[]:target.filters;
			filters.push(new GlowFilter(color,alpha,blurX,blurY,strength));
			target.filters=filters;
		}
		/**
		 *移出对象的描边 
		 * @param target
		 * 
		 */
		public static function removeStroke(target:DisplayObject):void
		{
			removeFilter(target,GlowFilter);
		}
		/**
		 *给一个DisplayObject添加发光动画 
		 * @param target 目标对象
		 * @param interval 触发频率 为0 表示一直显示
		 * @param color 颜色
		 * @repeat 重复次数
		 * @param blurX
		 * @param blurY
		 * @param strength
		 * @param alpha
		 * 
		 */
		public static function glow(target:DisplayObject,interval:Number,color:uint,repeat:int=-1,blurX:Number=10,blurY:Number=10,strength:int=3,alpha:Number=1):void
		{
			/*removeGlow(target);
			TweenMax.killTweensOf(target);
			
			if(interval>0)
			{
				var g:GlowFilter=new GlowFilter(0,0,0,0);
				target.filters=[g];
				TweenMax.to(target,interval,{yoyo:true,repeat:repeat,glowFilter:{color:color,blurX:blurX,blurY:blurY,alpha:alpha,strength:strength},
					onComplete:function():void
					{
						removeGlow(target);
					}});
			}else
			{
				target.filters=[new GlowFilter(color,alpha,blurX,blurY,strength)];
			}*/
		}
		/**
		 *移出一个DisplayObject的发光动画 
		 * @param target
		 * 
		 */
		public static function removeGlow(target:DisplayObject):void
		{
			/*TweenMax.killTweensOf(target);
			removeFilter(target，GlowFilter);*/
		}
		/**
		 *给DisplayObject添加忽明忽暗动画 
		 * @param target
		 * @param duration
		 * @param repeat
		 * 
		 */
		public static function lighten(target:DisplayObject,duration:Number,repeat:int=-1):void
		{
			/*TweenMax.to(target,duration,{yoyo:true,repeat:repeat,colorTransform:{tint:0xffffff,tintAmount:0.2},
				onComplete:function():void
				{
					removeLighten(target);
				}});*/	
		}
		/**
		 *移出DisplayObject的忽明忽暗动画 
		 * @param target
		 * 
		 */
		public static function removeLighten(target:DisplayObject):void
		{
			//TweenMax.to(target,0.1,{colorTransform:{tint:0xffffff,tintAmount:0}});
		}
	}
}