package com.popchan.algorithm.line
{
	import flash.display.BitmapData;
	import flash.geom.Point;

	/**
	 *直线生成算法 DDA和bresenham
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class LineGenerateCore
	{
		public function LineGenerateCore()
		{
			
		}
		/**
		 *得到DDA直线经过的点 
		 * @param sx 
		 * @param sy
		 * @param ex
		 * @param ey
		 * @param step
		 * @return 
		 * 
		 */
		public static function getDDALinePoints(sx:int,sy:int,ex:int,ey:int,step:int=1):Array
		{
			var points:Array=[];
			var steps:int;
			var dx:Number=ex-sx;
			var dy:Number=ey-sy;
			if(Math.abs(dx)>Math.abs(dy))
				steps=Math.abs(dx);
			else
				steps=Math.abs(dy);
			var stepx:Number=dx/steps*step;
			var stepy:Number=dy/steps*step;
			var tempX:Number=sx;
			var tempY:Number=sy;
			for(var i:int=1;i<=steps;i+=step)
			{
				tempX+=stepx;
				tempY+=stepy;
				points.push(new Point(tempX,tempY));
			}
			return points;
				
		}
		/**
		 * 得到Bresenham直线经过的点 
		 * @param x1
		 * @param y1
		 * @param x2
		 * @param y2
		 * @return 
		 * 
		 */
		public static function getBresenhamLinePoints(x1:int,y1:int,x2:int,y2:int):Array
		{
			var points:Array=[];
			var x:int;
			var y:int;
			var dx:int;
			var dy:int;
			var s1:int;
			var s2:int;
			var p:int;
			var temp:int;
			var interchange:int;
			var i:int;
			x=x1;
			y=y1;
			dx=Math.abs(x2-x1);
			dy=Math.abs(y2-y1);
			if(x2>x1)
				s1=1;
			else
				s1=-1;
			if(y2>y1)
				s2=1;
			else
				s2=-1;
			if(dy>dx)
			{
				temp=dx;
				dx=dy;
				dy=temp;
				interchange=1;
			}else
				interchange=0;
			p=2*dy-dx;
			for(i=1;i<=dx;i++)
			{
				points.push(new Point(x,y));
				if(p>=0)
				{
					if(interchange==0)
						y=y+s2;
					else
						x=x+s1;
					p=p-2*dx;
				}
				if(interchange==0)
					x=x+s1;
				else
					y=y+s2;
				p=p+2*dy;
			}
			return points;
		}
	}
}