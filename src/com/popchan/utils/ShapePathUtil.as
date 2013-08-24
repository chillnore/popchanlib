package com.popchan.utils
{
	import flash.geom.Point;

	/**
	 *获取形状的路径
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class ShapePathUtil
	{
		public function ShapePathUtil()
		{
		}
		/**
		 *圆 
		 * @param centerX
		 * @param centerY
		 * @param r
		 * @return 
		 * 
		 */
		static public function getRoundPoint(centerX:Number,centerY:Number,r:Number):Point
		{
			var angle:Number=Math.random()*360;
			var radius:Number=angle*Math.PI/180;
			var x:Number=Math.cos(radius)*r+centerX;
			var y:Number=Math.sin(radius)*r+centerY;
			return new Point(x,y);
		}
		
		/**
		 *菱形 
		 * @param centerX
		 * @param centerY
		 * @param r
		 * @return 
		 * 
		 */
		static public function getDiamondPoint(centerX:Number,centerY:Number,r:Number):Point
		{
			var x:Number=Math.random()*r+centerX-r;
			var y:Number=Math.random()*r+centerY-r;
			return new Point(x,y);
		}
		/**
		 *正玄 
		 * @param centerX
		 * @param centerY
		 * @param r
		 * @return 
		 * 
		 */
		static public function getSinePoint(centerX:Number,centerY:Number,r:Number):Point
		{
			var x:Number=Math.random()*((4*Math.PI)-(-4*Math.PI))+(-4*Math.PI);
			var y:Number=Math.sin(x)*r;
			x=x*r+centerX;
			y=y+centerY;
			return new Point(x,y);
		}
		/**
		 *螺旋 
		 * @param centerX
		 * @param centerY
		 * @param r
		 * @return 
		 * 
		 */
		static public function getEddyPoint(centerX:Number,centerY:Number,r:Number):Point
		{
			var angle:Number=Math.random()*(360*4);
			var radius:Number=angle*Math.PI/180;
			var x:Number=angle*Math.cos(radius)/r+centerX;
			var y:Number=angle*Math.sin(radius)/r+centerY;
			return new Point(x,y);
		}
		/**
		 *五角星 
		 * @param centerX
		 * @param centerY
		 * @param r
		 * @return 
		 * 
		 */
		static public function getStarPoint(centerX:Number,centerY:Number,r:Number):Point
		{
			var x:Number;
			var y:Number;
			var cx:Number=15*r;
			var cy:Number=8*r;
			var pointX:Array=new Array(5);
			var pointY:Array=new Array(5);
			
			for(var i:int=0;i<5;i++)
			{
				var da:Number=(i*0.8-0.5)*Math.PI;
				pointX[i]=cx*(0.25+0.24*Math.cos(da));
				pointY[i]=cy*(0.5+0.48*Math.sin(da));
			}
			var n:int=Math.random()*5;
			var m:int=(n+1)==5?0:(n+1);
			if(pointX[n]>pointX[m])
				x=Math.random()*(pointX[n]-pointX[m])+pointX[m];
			else
				x=Math.random()*(pointX[m]-pointX[n])+pointX[n];
			
			y=((pointY[m]-pointY[n])/(pointX[m]-pointX[n]))*(x-pointX[n])+pointY[n]+centerY;
			x=x+centerX-cx/5;
			y=y-cy/2;
			
			return new Point(x,y);
		}
	}
}