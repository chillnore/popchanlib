package com.popchan.algorithm.rpg
{
	import flash.geom.Point;

	/**
	 *斜视角地图坐标转换
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class GamePointUtil
	{
		/**
		 *任意角度的屏幕坐标转换为游戏坐标 
		 * @param point
		 * @param tileSize 菱形的边长
		 * @return 
		 * 
		 */
		static public function screenToGame(p:Point,tileSize:int,angle:Number):Point
		{
			if(angle==0)
			{
				return new Point(int(p.x/tileSize),int(p.y/tileSize));
			}
			else
			{
				var radian:Number=Math.PI*angle/180;
				return new Point(int((p.y/Math.sin(radian/2)-p.x/Math.cos(radian/2))/(2*tileSize)),
					int((p.y/Math.sin(radian/2)+p.x/Math.cos(radian/2))/(2*tileSize)));
			}
		}
		/**
		 *任意角度的游戏坐标转换为屏幕坐标 
		 * @param point
		 * @param tileSize 菱形的边长
		 * @return 
		 * 
		 */
		static public function gameToScreen(p:Point,tileSize:int,angle:Number):Point
		{
			if(angle==0)
			{
				return new Point(p.x*tileSize,p.y*tileSize);
			}else
			{
				var radian:Number=Math.PI*angle/180;
				return new Point((p.y-p.x)*Math.cos(radian/2)*tileSize,(p.y+p.x)*Math.sin(radian/2)*tileSize);
			}
		}
		/**
		 *斜45度坐标转换为屏幕坐标
		 * @param p
		 * @param tileWidth
		 * @param tileHeight
		 * @return 
		 * 
		 */
		static public function isoToScreen(p:Point,tileWidth:int,tileHeight:int):Point
		{
			return new Point((p.x-p.y)*tileWidth>>1,(p.y+p.x)*tileHeight>>1);
		}
		/**
		 * 屏幕坐标转换为斜45度坐标
		 * @param p
		 * @param tileWidth
		 * @param tileHeight
		 * @return 
		 * 
		 */
		static public function screenToIso(p:Point,tileWidth:int,tileHeight:int):Point
		{
			return new Point(int(p.y/tileHeight+p.x/tileWidth),int(p.y/tileHeight-p.x/tileWidth));
		}
		/**
		 *根据弧度获取方向8个方向，从X正方形顺时针旋转0-7个方向 
		 * @param radian
		 * @return 
		 * 
		 */
		static public function getDirection(radian:Number):int
		{
			if((radian<=1/8*Math.PI&&radian>0)||(radian<=0&&radian>-1/8*Math.PI))
				return 0;
			else if(radian<=3/8*Math.PI&&radian>1/8*Math.PI)
				return 1;
			else if(radian<=5/8*Math.PI&&radian>3/8*Math.PI)
				return 2;
			else if(radian<=7/8*Math.PI&&radian>5/8*Math.PI)
				return 3;
			else if((radian<=Math.PI&&radian>7/8*Math.PI)||(radian<=-7/8*Math.PI&&radian>-Math.PI))
				return 4;
			else if(radian<=-5/8*Math.PI&&radian>-7/8*Math.PI)
				return 5;
			else if(radian<=-3/8*Math.PI&&radian>-5/8*Math.PI)
				return 6;
			else if(radian<=-1/8*Math.PI&&radian>-3/8*Math.PI)
				return 7;
			return -1;
		}
	}
}