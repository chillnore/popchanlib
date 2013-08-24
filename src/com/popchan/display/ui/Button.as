package com.popchan.display.ui
{
	import com.popchan.utils.FilterUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 *带文本的按钮
	 * 	属性
	 * 		1.btn.label 文本
	 * 		2.btn.color 文本颜色
	 * 		3.btn.fontSize 文本字体大小
	 * 		4. stroke 文本描边
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class Button extends ButtonBase
	{
		protected var _label:String="button";
		protected var _tf:TextField;
		protected var _textformat:TextFormat;
		public function Button(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,label:String=null)
		{
			super(parent, x, y);
			if(label!=null)
				this.label=label;
		}
		
		override protected function preInit():void
		{
			super.preInit();
			_width=80;
			_height=28;
		}
		
		
		override protected function createChildren():void
		{
			_textformat=new TextFormat();
			_tf=new TextField();
			_tf.autoSize=TextFieldAutoSize.LEFT;
			_tf.width=_width;
			_tf.height=_height;
			_tf.defaultTextFormat=_textformat;
			addChild(_tf);
		}
		
		
		public function get label():String
		{
			return _label;
		}
		
		public function set label(value:String):void
		{
			if(value!=_label)
			{
				_label = value;
				invalidate(CallLaterType.SIZE);
			}
		}
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			mouseEnabled=false;
			_tf.alpha=value?1:.5;
		}
		
		protected function drawText():void
		{
			_tf.defaultTextFormat=_textformat;
			_tf.text=_label;
			_tf.autoSize=TextFieldAutoSize.LEFT;
			if(_tf.width>_width-4)
			{
				_tf.autoSize=TextFieldAutoSize.NONE;
				_tf.width=_width-4;
			}
			_tf.x=_width-_tf.width>>1;
			_tf.y=_height-_tf.height>>1;
		}
		/**
		 *文本字体大小 
		 * @return 
		 * 
		 */
		public function get fontSize():int
		{
			return _textformat.size as int;
		}
		public function set fontSize(value:int):void
		{
			_textformat.size=value;
			invalidate(CallLaterType.SIZE);
		}
		/**
		 *文本字体颜色
		 * @return 
		 * 
		 */
		public function get color():uint
		{
			return _textformat.color as uint;
		}
		public function set color(value:uint):void
		{
			_textformat.color=value;
			invalidate(CallLaterType.SIZE);
		}
		/**
		 *描边 
		 * @param value
		 * 
		 */
		public function set stroke(value:Boolean):void
		{
			if(value)
				FilterUtil.stroke(_tf,0,2,2,10);
			else
				FilterUtil.removeStroke(_tf);
		}
		
		override protected function draw():void
		{
			if(isCallLater(CallLaterType.SKIN))
			{
				drawBg();
				invalidate(CallLaterType.SIZE,false);
			}
			if(isCallLater(CallLaterType.SIZE))
			{
				changeBgSzie();
				drawText();
			}
			clearCallLater();
		}
		
	}
}