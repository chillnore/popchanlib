package com.popchan.utils
{
	
	import com.popchan.display.bitmap.BitmapFrameInfo;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	

	/**
	 *bitmap操作工具
	 *@create 2012
	 *@author chenbo
	 */
	public class BitmapUtil
	{
		public function BitmapUtil()
		{
			
		}
		/**
		 *位图九宫格 
		 * @param source
		 * @param grids
		 * @param width
		 * @param height
		 * @return 
		 * 
		 */
		public static function scaleGrid9Bmd(source:BitmapData,grids:Array,width:int,height:int):BitmapData
		{
			if(source.width==width&&source.height==height)return source;
			var scrollRect:Rectangle=new Rectangle(grids[0],grids[1],grids[2]-grids[0],grids[3]-grids[1]);
			var right:int = width - scrollRect.right;
			var bottom:int = height - scrollRect.bottom;
			var result:BitmapData = new BitmapData(width,height,source.transparent,0);
			var i:int;
			var len:int;
			var dx:int = width - scrollRect.x - (source.width - scrollRect.right);
			var dy:int = height - scrollRect.y - (source.height - scrollRect.bottom);
			var lenx:int = Math.ceil(dx / scrollRect.width);
			var leny:int = Math.ceil(dy / scrollRect.height);
			for (i = 0;i < lenx;i++)
			{
				result.copyPixels(source,new Rectangle(scrollRect.x,0,scrollRect.width,scrollRect.y),new Point(scrollRect.x + i * scrollRect.width,0));
			}
			for (i = 0;i < leny;i++)
			{
				result.copyPixels(source,new Rectangle(0,scrollRect.y,scrollRect.x,scrollRect.height),new Point(0,scrollRect.y + i * scrollRect.height));
			}
			for (i = 0;i < leny;i++)
			{
				for (var j:int = 0;j < lenx;j++)
				{
					result.copyPixels(source,scrollRect,new Point(scrollRect.x + j * scrollRect.width,scrollRect.y + i * scrollRect.height));
				}
			}
			for (i = 0;i < lenx;i++)
			{
				result.copyPixels(source,new Rectangle(scrollRect.x,scrollRect.bottom,scrollRect.width,source.height - scrollRect.bottom),new Point(scrollRect.x + i * scrollRect.width,height - (source.height - scrollRect.bottom)));
			}
			for (i = 0;i < leny;i++)
			{
				result.copyPixels(source,new Rectangle(scrollRect.right,scrollRect.y,source.width - scrollRect.right,scrollRect.height),new Point(width - (source.width - scrollRect.right),scrollRect.y + i * scrollRect.height));
			}
			result.copyPixels(source,new Rectangle(0,0,scrollRect.x,scrollRect.y),new Point());
			result.copyPixels(source,new Rectangle(scrollRect.right,0,source.width - scrollRect.right,scrollRect.y),new Point(width - (source.width - scrollRect.right),0));
			result.copyPixels(source,new Rectangle(0,scrollRect.bottom,scrollRect.x,source.height - scrollRect.bottom),new Point(0,height - (source.height - scrollRect.bottom)));
			result.copyPixels(source,new Rectangle(scrollRect.right,scrollRect.bottom,source.width - scrollRect.right,source.height - scrollRect.bottom),new Point(width - (source.width - scrollRect.right),height - (source.height - scrollRect.bottom)));
			return result;
		}
		/**
		 *将mc转化成位图，保存帧标签 
		 * @param mc
		 * @param scale
		 * @param getValidRect
		 * @return 
		 * 
		 */
		public static function trim(mc:MovieClip,scale:Number=1,getValidRect:Boolean=true):Vector.<BitmapFrameInfo>
		{
			var frameInfo:BitmapFrameInfo;
			var i:int=0;
			var len:int=mc.totalFrames;
			var list:Vector.<BitmapFrameInfo>=new Vector.<BitmapFrameInfo>();
			mc.gotoAndStop(1);
			while(i<len)
			{
				var rect:Rectangle=mc.getRect(mc);
				rect.x*=scale;
				rect.y*=scale;
				if(!rect.isEmpty())
				{
					var matrix:Matrix=new Matrix(scale,0,0,scale,-rect.x,-rect.y);
					var bmd:BitmapData=new BitmapData(rect.width*scale,rect.height*scale,true,0);
					bmd.draw(mc,matrix);
					if(getValidRect)
					{
						var valid:Rectangle=bmd.getColorBoundsRect(0xff000000,0x00000000,false);
						if(!valid.isEmpty())
						{
							matrix.tx-=valid.x;
							matrix.ty-=valid.y;
							var tempBmd:BitmapData=bmd;
							bmd=new BitmapData(valid.width,valid.height,true,0);
							bmd.copyPixels(tempBmd,valid,new Point());
							tempBmd.dispose();
						}
					}
					frameInfo=new BitmapFrameInfo();
					frameInfo.bitmapData=bmd;
					frameInfo.offsetX=matrix.tx;
					frameInfo.offsetY=matrix.ty;
					frameInfo.label=mc.currentLabel;
					list.push(frameInfo);
				}
				mc.nextFrame();
				i++;
			}
			return list;
		}
		/**
		 *切割位图
		 * @param source
		 * @param tilesPreRow
		 * 
		 */
		public static function trimBmd(source:BitmapData,rowCount:int,colCount:int):Array
		{
			var list:Array=[];
			var rowHeight:int=source.height/rowCount;
			var colWidth:int=source.width/colCount;
			for(var i:int=0;i<rowCount;i++)
			{
				for(var j:int=0;j<colCount;j++)
				{
					var bmd:BitmapData=new BitmapData(colWidth,rowHeight,true,0);
					bmd.copyPixels(source,new Rectangle(j*colWidth,i*rowHeight,colWidth,rowHeight),new Point(0,0));
					list.push(bmd);
				}
			}
			return list;
		}
	}
}