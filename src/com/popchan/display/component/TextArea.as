package com.popchan.display.component
{
	import com.popchan.manager.ResourceManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	/**
	 *多行文本控件
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class TextArea extends Component
	{
		protected var _scrollBar:VScrollBar;
		protected var _text:String="";
		protected var _isHtml:Boolean;
		protected var _tf:TextField;
		protected var _back:Image;
		protected var _scale9:String="12,7,45,9";
		protected var _textformat:TextFormat;
		public function TextArea(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skin:String="Skin_textinput")
		{
			super(parent, x, y);
			this.skin=skin;
		}
		
		override protected function config():void
		{
			setSize(200,250);
			
			_back=new Image(this);
			_back.scale9=_scale9;
			
			_tf=new TextField();
			_tf.height=_height;
			_tf.multiline=true;
			_tf.wordWrap=true;
			_tf.type=TextFieldType.INPUT;
			addChild(_tf);
			
			_scrollBar=new VScrollBar(this,_width-16,0);
			_scrollBar.policy="auto";
			_scrollBar.addEventListener(Event.CHANGE,onScroll);
			_scrollBar.height=_height;
			
			editable=true;
			_textformat=new TextFormat();
			this.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
			
		}
	
		
		/**
		 *鼠标滚轮处理 
		 * @param event
		 * 
		 */
		protected function onMouseWheel(event:MouseEvent):void
		{
			_scrollBar.value-=event.delta;
		}
		
		protected function onScroll(event:Event):void
		{
			_tf.scrollV=_scrollBar.value;
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
		override protected function draw():void
		{
			if(isCallLater(CallLaterEnum.SKIN))
			{
				_back.bitmapData=ResourceManager.getBitmapData(_skin);
			}
			if(isCallLater(CallLaterEnum.SIZE))
			{
				if(_back)
				{
					_back.width=_width;
					_back.height=_height;
					_back.validateNow();
				}
				_tf.height=_height;
				_tf.width=_width-_scrollBar.width;
				_scrollBar.height=_height;
				_scrollBar.x=_width-_scrollBar.width;
				invalidate(CallLaterEnum.DATA,false);
				
			}
			if(isCallLater(CallLaterEnum.DATA))
			{
				_tf.defaultTextFormat=_textformat;
				if(_isHtml)
					_tf.htmlText=_text;
				else
					_tf.text=_text;
				
				_scrollBar.minimum=1;
				_scrollBar.maximum=_tf.maxScrollV;
				_scrollBar.value=_tf.scrollV;
				_scrollBar.pageScrollSize=_tf.numLines-_tf.maxScrollV+1;
				_scrollBar.setThumbPercent((_tf.numLines-_tf.maxScrollV+1)/_tf.numLines);
				_scrollBar.validateNow();
				if(!_scrollBar.visible)
					_tf.width=_width;
				else
					_tf.width=_width-16;
			}
			clearCallLater();
		}
		/**
		 *设置垂直滚动条的位置
		 * @param value
		 * 
		 */
		public function set verticalScrollPosition(value:int):void
		{
			_scrollBar.value=value;
			onScroll(null);
		}
		/**
		 *获取滚动条的最大位置 
		 * @return 
		 * 
		 */
		public function get maxVerticalScrollPosition():int
		{
			return _tf.maxScrollV;
		}
		/**
		 *垂直滚动条显示策略 
		 * @param value
		 * 
		 */
		public function set verticalScrollPolicy(value:String):void
		{
			_scrollBar.policy=value;
			invalidate(CallLaterEnum.SIZE);
		}
		/**
		 *是否可以编辑 
		 * @return 
		 * 
		 */
		public function get editable():Boolean
		{
			return _tf.type==TextFieldType.INPUT?true:false;
		}
		public function set editable(value:Boolean):void
		{
			if(value)
			{
				_tf.type=TextFieldType.INPUT;
				_tf.addEventListener(Event.CHANGE,onTextChange,false,0,true);
			}
			else
			{
				_tf.type=TextFieldType.DYNAMIC;
				_tf.removeEventListener(Event.CHANGE,onTextChange);
			}
		}
		
		protected function onTextChange(event:Event):void
		{
			if(_isHtml)
				_text=_tf.htmlText;
			else
				_text=_tf.text;
			invalidate(CallLaterEnum.DATA);
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
		public function get maxChars():int
		{
			return _tf.maxChars;
		}
		/**
		 *追加文本 
		 * @param value
		 * 
		 */
		public function appendText(value:String):void
		{
			_tf.appendText(value);
		}
		public function get scale9():String
		{
			return _scale9;
		}
		
		public function set scale9(value:String):void
		{
			_scale9 = value;
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