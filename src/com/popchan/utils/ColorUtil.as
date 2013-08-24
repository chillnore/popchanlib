package com.popchan.utils
{
	/**
	 *颜色操作工具
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class ColorUtil
	{
		/**
		 *按照颜色值调整亮度 
		 * @param rgb
		 * @param brite -255-255
		 * @return 
		 * 
		 */
		public static function adjustBrightness(rgb:uint, brite:Number):uint
		{
			var r:Number = Math.max(Math.min(((rgb >> 16) & 0xFF) + brite, 255), 0);
			var g:Number = Math.max(Math.min(((rgb >> 8) & 0xFF) + brite, 255), 0);
			var b:Number = Math.max(Math.min((rgb & 0xFF) + brite, 255), 0);
			
			return (r << 16) | (g << 8) | b;
		} 
		
		
		/**
		 *按照比例调整亮度 
		 * @param rgb
		 * @param brite 0-100
		 * @return 
		 * 
		 */
		public static function adjustBrightness2(rgb:uint, brite:Number):uint
		{
			var r:Number;
			var g:Number;
			var b:Number;
			
			if (brite == 0)
				return rgb;
			
			if (brite < 0)
			{
				brite = (100 + brite) / 100;
				r = ((rgb >> 16) & 0xFF) * brite;
				g = ((rgb >> 8) & 0xFF) * brite;
				b = (rgb & 0xFF) * brite;
			}
			else 
			{
				brite /= 100;
				r = ((rgb >> 16) & 0xFF);
				g = ((rgb >> 8) & 0xFF);
				b = (rgb & 0xFF);
				
				r += ((0xFF - r) * brite);
				g += ((0xFF - g) * brite);
				b += ((0xFF - b) * brite);
				
				r = Math.min(r, 255);
				g = Math.min(g, 255);
				b = Math.min(b, 255);
			}
			
			return (r << 16) | (g << 8) | b;
		}
		
		/**
		 *正片叠底的方式合并2个颜色值 
		 * @param rgb1
		 * @param rgb2
		 * @return 
		 * 
		 */
		public static function rgbMultiply(rgb1:uint, rgb2:uint):uint
		{
			var r1:Number = (rgb1 >> 16) & 0xFF;
			var g1:Number = (rgb1 >> 8) & 0xFF;
			var b1:Number = rgb1 & 0xFF;
			
			var r2:Number = (rgb2 >> 16) & 0xFF;
			var g2:Number = (rgb2 >> 8) & 0xFF;
			var b2:Number = rgb2 & 0xFF;
			
			return ((r1 * r2 / 255) << 16) |
				((g1 * g2 / 255) << 8) |
				(b1 * b2 / 255);
		} 
	}
}