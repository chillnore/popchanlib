package com.popchan.display.component
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
		protected var _stroke:String="";
		protected var _autoSize:Boolean;
		public function Button(label:String=null,parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skinName:String="Skin_button")
		{
			super(parent, x, y,skinName);
			if(label!=null)
				this.label=label;
		}
		
		
		override protected function config():void
		{
			super.config();
			
			_textformat=new TextFormat();
			_textformat.size=12;
			_textformat.color=0x0;
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
				invalidate(CallLaterEnum.DATA);
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
			if(_autoSize)
			{
				_width=_tf.width+4;
				changeBgSzie();
				drawBg();
			}else
			{
				if(_tf.width>_width-4)
				{
					_tf.autoSize=TextFieldAutoSize.NONE;
					_tf.width=_width-4;
				}
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
			invalidate(CallLaterEnum.DATA);
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
			invalidate(CallLaterEnum.DATA);
		}
		/**
		 *描边 
		 * @param value[color,blurx,blury,strength,alpha]
		 * 
		 */
		public function set stroke(value:String):void
		{
			_stroke=value;
			FilterUtil.removeStroke(_tf);
			var arr:Array=[_tf];
			arr=arr.concat(value.split(","));
			FilterUtil.stroke.apply(null,arr);
		}
		public function get stroke():String
		{
			return _stroke;
		}
		
		override protected function draw():void
		{
			if(isCallLater(CallLaterEnum.SIZE))
			{
				changeBgSzie();
				invalidate(CallLaterEnum.DATA,false);
				invalidate(CallLaterEnum.SKIN,false);
				
			}
			if(isCallLater(CallLaterEnum.SKIN))
			{
				drawBg();
			}
			isCallLater(CallLaterEnum.DATA)
			{
				drawText();
			}
			clearCallLater();
		}
		
		/**
		 *按钮大小是否随文字的长度而变化 
		 */
		public function get autoSize():Boolean
		{
			return _autoSize;
		}
		
		/**
		 * @private
		 */
		public function set autoSize(value:Boolean):void
		{
			_autoSize = value;
			invalidate(CallLaterEnum.DATA);
		}
		
		
	}
}