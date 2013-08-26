package com.popchan.display.component
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 *多行文本
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class Text extends Label
	{
		public function Text(text:String="多行文本控件", parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(text, parent, x, y);
		}
		override protected function config():void
		{
			super.config();
			
			_width=100;
			_height=100;
			_tf.width=_width;
			_tf.height=_height;
			_tf.multiline=true;
			_tf.wordWrap=true;
		}
	}
}