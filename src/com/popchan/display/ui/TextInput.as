package com.popchan.display.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	/**
	 *单行文本输入框控件
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	[Event(name="change", type="flash.events.Event")]
	[Event(name="textInput", type="flash.events.TextEvent")]
	[Event(name="enter", type="com.popchan.display.ui.ComponentEvent")]
	public class TextInput extends Component
	{
		protected var _tf:TextField;
		protected var _back:Sprite;
		protected var _text:String="";
		protected var _textformat:TextFormat;
		protected var _defaultSkin:Object=
			{
				backSkin:"TextInputBackSkin"
			};
		public function TextInput(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}
		
		override protected function preInit():void
		{
			_width=100;
			_height=22;
			_skin=_defaultSkin;
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode==Keyboard.ENTER)
			{
				dispatchEvent(new ComponentEvent(ComponentEvent.ENTER));
			}
		}		
		
		override protected function createChildren():void
		{
			_tf=new TextField();
			_tf.type=TextFieldType.INPUT;
			_tf.wordWrap=false;
			addChild(_tf);
			_tf.addEventListener(Event.CHANGE,onChange);
			_tf.addEventListener(TextEvent.TEXT_INPUT,onTextInput);
			
			_textformat=new TextFormat();
		}
		
		protected function onTextInput(event:TextEvent):void
		{
			dispatchEvent(event);
		}
		
		protected function onChange(event:Event):void
		{
			dispatchEvent(event);
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
				_back.width=_width;
				_back.height=_height;
				_tf.width=_width;
				_tf.height=_height;
			}
			clearCallLater();
		}
		
		private function drawBg():void
		{
			if(_back)
			{
				removeChild(_back);
			}
			_back=getSkinInstance(getStyleValue("backSkin")) as Sprite;
			_back.width=_width;
			_back.height=_height;
			addChildAt(_back,0);
		}		
		
		/**
		 *文本 
		 */
		public function get text():String
		{
			return _tf.text;
		}
		
		/**
		 * @private
		 */
		public function set text(value:String):void
		{
			_text = value;
			_tf.text=value;
		}
		public function get maxChars():int
		{
			return _tf.maxChars;
		}
		/**
		 *可输入的最大字符数 
		 * @param value
		 * 
		 */
		public function set maxChars(value:int):void
		{
			_tf.maxChars=value;
		}
		/**
		 * 指示用户可以输入到控件的字符集
		 * @param value
		 * 
		 */
		public function set restrict(value:String):void
		{
			_tf.restrict=value;
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
		}
	}
}