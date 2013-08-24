package com.popchan.utils
{
	import flash.geom.Point;

	/**
	 *几何类
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class GeomUtil
	{
		/**
		 * 弧度转角度
		 * @param radians
		 * @return 
		 * 
		 */
		public static function radiansToDegree(radians:Number):Number
		{
			return radians*180/Math.PI;
		}
		/**
		 * 角度转弧度
		 * @param radians
		 * @return 
		 * 
		 */
		public static function degreeToRadians(degree:Number):Number
		{
			return degree*Math.PI/180;
		}
		/**
		 * 获取两点的距离 
		 * @param p1
		 * @param p2
		 * @return 
		 * 
		 */
		public static function getDistance(p1:Point,p2:Point):Number
		{
			var dx:Number=p2.x-p1.x;
			var dy:Number=p2.y-p1.y;
			return Math.sqrt(dx*dx+dy*dy);
		}
		/**
		 *获取两点之间的弧度 
		 * @param p1
		 * @param p2
		 * @return 
		 * 
		 */
		public static function getRadians(p1:Point,p2:Point):Number
		{
			var dx:Number=p2.x-p1.x;
			var dy:Number=p2.y-p1.y;
			return Math.atan2(dy,dx);
		}
		/**
		 *得到一个点围绕另1个点旋转指定角度后的坐标 
		 * @param point
		 * @param centerPoint
		 * @param angle
		 * @return 
		 * 
		 */
		public static function getRotatePoint(point:Point, centerPoint:Point, angle:Number):Point
		{
			var r:Number=degreeToRadians(angle);
			var baseX:Number = point.x - centerPoint.x;
			var baseY:Number = point.y - centerPoint.y;
			
			point.x = (Math.cos(r) * baseX) - (Math.sin(r) * baseY) + centerPoint.x;
			point.y = (Math.sin(r) * baseX) + (Math.cos(r) * baseY) + centerPoint.y;
			return point;
		}
	}
}