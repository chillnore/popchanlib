package com.popchan.display.component
{
	import com.popchan.utils.FilterUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	/**
	 *单行文本
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class Label extends Component
	{
		protected var _isHtml:Boolean;
		protected var _text:String;
		protected var _tf:TextField;
		protected var _textformat:TextFormat;
		protected var _stroke:String="";
		public function Label(text:String="label",parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
			this.text=text;
		}
		override protected function config():void
		{
			_width=150;
			_height=22;
			
			_textformat=new TextFormat();
			_textformat.size=12;
			_textformat.color=0x0;
			
			_tf=new TextField();
			_tf.defaultTextFormat=_textformat;
			_tf.width=_width;
			_tf.height=_height;
			_tf.multiline=false;
			_tf.selectable=false;
			addChild(_tf);
		}
		/**
		 *显示的文本 
		 * @return 
		 * 
		 */
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			_text = value;
			_isHtml=false;
			invalidate(CallLaterEnum.DATA);
		}
		public function set htmlText(value:String):void
		{
			_text=value;
			_isHtml=true;
			invalidate(CallLaterEnum.DATA);
		}
		/**
		 *显示的Html文本 
		 * @return 
		 * 
		 */
		public function get htmlText():String
		{
			return _text;
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
		
		
		override protected function draw():void
		{
			if(isCallLater(CallLaterEnum.SIZE))
			{
				_tf.width=_width;
				_tf.height=_height;
			}
			if(isCallLater(CallLaterEnum.DATA))
			{
				_tf.defaultTextFormat=_textformat;
				if(_isHtml)
					_tf.htmlText=_text;
				else
					_tf.text=_text;
			}
			clearCallLater();
		}

		/**
		 *是否可选 
		 * @return 
		 * 
		 */
		public function get selectable():Boolean
		{
			return _tf.selectable;
		}

		public function set selectable(value:Boolean):void
		{
			_tf.selectable=value;
		}
		/**
		 *描边 
		 * @param value[color,blurx,blury,strength,alpha]
		 * 
		 */
		public function set stroke(value:String):void
		{
			_stroke=value;
			FilterUtil.removeStroke(this);
			var arr:Array=[this];
			arr=arr.concat(value.split(","));
			FilterUtil.stroke.apply(null,arr);
		}
		public function get stroke():String
		{
			return _stroke;
		}
		
	}
}