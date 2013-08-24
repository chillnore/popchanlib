package com.popchan.debug
{
	import com.popchan.utils.FilterUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.system.System;
	import flash.text.TextField;
	import flash.utils.getTimer;

	/**
	 *帧频 内存检测工具
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class FPS extends Sprite
	{
		private var t:int;
		private var time:int;
		private var frames:int;
		private var fpsTxt:TextField;
		private var memTxt:TextField;
		
		public function FPS()
		{
			this.addEventListener(Event.ENTER_FRAME,loop);
			t=getTimer();
			
			var bmp:Bitmap=new Bitmap();
			bmp.bitmapData=new BitmapData(102,50,true,0xaa000000);
			addChild(bmp);
			
			fpsTxt=new TextField();
			fpsTxt.selectable=false;
			fpsTxt.textColor=0x00ff00;
			fpsTxt.autoSize="left";
			addChild(fpsTxt);
			FilterUtil.stroke(fpsTxt);
			
			memTxt=new TextField();
			memTxt.selectable=false;
			memTxt.textColor=0xff0000;
			memTxt.width=100;
			memTxt.height=20;
			memTxt.autoSize="left";
			memTxt.y=20;
			addChild(memTxt);
			FilterUtil.stroke(memTxt);
		}
		
		protected function loop(event:Event):void
		{
			time=getTimer()-t;
			if(time>1000)
			{
				fpsTxt.text="FPS:"+frames+"/"+stage.frameRate;
				
				t=getTimer();
				frames=0;
			}else
			{
				frames++;
			}
			memTxt.text="MEM:"+(System.totalMemory/1024/1024).toFixed(2)+"MB";
			
			
			
		}
	}
}