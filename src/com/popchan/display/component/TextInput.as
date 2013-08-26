package com.popchan.display.component
{
	import com.popchan.manager.ResourceManager;
	
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
		protected var _back:Image;
		protected var _text:String="";
		protected var _textformat:TextFormat;
		protected var _scale9:String="12,7,45,9";

		public function TextInput(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skin:String="Skin_textinput")
		{
			super(parent, x, y);
			this.skin=skin;
		}
	
		override protected function config():void
		{
			_width=100;
			_height=22;
			
			
			_back=new Image(this);
			_back.scale9=_scale9;
			_back.setSize(_width,_height);
			
			_tf=new TextField();
			_tf.type=TextFieldType.INPUT;
			_tf.wordWrap=false;
			addChild(_tf);
			_tf.addEventListener(Event.CHANGE,onChange);
			_tf.addEventListener(TextEvent.TEXT_INPUT,onTextInput);
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			
			_textformat=new TextFormat();
		}
		
		protected function onAddToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode==Keyboard.ENTER)
			{
				dispatchEvent(new ComponentEvent(ComponentEvent.ENTER));
			}
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
			if(isCallLater(CallLaterEnum.SKIN))
			{
				_back.bitmapData=ResourceManager.getBitmapData(_skin);
			}
			if(isCallLater(CallLaterEnum.SIZE))
			{
				_back.width=_width;
				_back.height=_height;
				_tf.width=_width;
				_tf.height=_height;
				_back.validateNow();
			}
			clearCallLater();
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

		public function get scale9():String
		{
			return _scale9;
		}

		public function set scale9(value:String):void
		{
			_scale9 = value;
		}

		public function get displayAsPassword():Boolean
		{
			return _tf.displayAsPassword;
		}

		public function set displayAsPassword(value:Boolean):void
		{
			_tf.displayAsPassword=value;
		}

	}
}