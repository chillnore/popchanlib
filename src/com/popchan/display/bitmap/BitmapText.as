package com.popchan.display.bitmap
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 *位图文字
	 *@create 2012
	 *@author chenbo
	 */
	public class BitmapText extends Bitmap
	{
		private var souce:BitmapData;
		private var titleWidth:int;
		private var titleHeight:int;
		private var queue:String;
		private var _text:String;
		private var offset:int;
		private var rect:Rectangle;
		private var point:Point;
		/**
		 * 
		 * @param source 源位图
		 * @param titleWidth
		 * @param titleHeight
		 * @param offset 偏移量
		 * @param queue 序列
		 * 
		 */
		public function BitmapText(source:BitmapData,titleWidth:int,titleHeight:int,offset:int=0,queue:String="0123456789")
		{
			this.souce=source;
			this.titleWidth=titleWidth;
			this.titleHeight=titleHeight;
			this.queue=queue;
			this.offset=offset;
			rect=new Rectangle(0,0,titleWidth,titleHeight);
			point=new Point();
		}

		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			if(value!=null)
			{
				_text = value;
				
				draw();
			}
		}
		/**
		 *绘制 
		 * 
		 */
		private function draw():void
		{
			if(bitmapData!=null)
				bitmapData.dispose();
			bitmapData=new BitmapData(text.length*titleWidth,titleHeight,true,0);
			
			var len:int=text.length;
			var index:int;
			var disW:int;
			for(var i:int=0;i<len;i++)
			{
				index=queue.indexOf(text.charAt(i));
				rect.x=index*titleWidth;
				point.x=i*(titleWidth+offset);
				bitmapData.copyPixels(souce,rect,point,null,null,true);
			}
		}
		
	}
}