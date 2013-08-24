package com.popchan.display.ui
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 *窗口类
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class Window extends Component
	{
		/**
		 *窗口标题栏 
		 */
		protected var _titleBar:Sprite;
		protected var _title:String;
		/**
		 *窗口标题文字 
		 */
		protected var _titleText:TextField;
		protected var _closeBtn:ButtonBase;
		/**
		 *是否有关闭按钮 
		 */
		protected var _hasCloseBtn:Boolean;
		/**
		 *窗口背景 
		 */
		protected var _back:Sprite;
		/**
		 *容器，存放item 
		 */
		protected var _box:Sprite;
		
		private var _panelSkin:Object={windowBackSkin:"WindowBackSkin"};
		private var _titleSkin:Object={windowTitleSkin:"WindowTitleSkin"};
		private var _closeBtnSkin:Object={upSkin:"CloseBtnUp",overSkin:"CloseBtnOver",downSkin:"CloseBtnDown"};
		private var _defaultSkin:Object=
			{
				windowBackSkin:"WindowBackSkin",
				windowTitleSkin:"WindowTitleSkin",
				upSkin:"CloseBtnUp",
				overSkin:"CloseBtnOver",
				downSkin:"CloseBtnDown"
			}
		public function Window(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
			
		}
		
		override protected function preInit():void
		{
			setSize(400,300);
		}
		override public function addChild(child:DisplayObject):DisplayObject
		{
			_box.addChild(child);
			return child;
		}
		public function thisAddChild(child:DisplayObject):DisplayObject
		{
			super.addChild(child);
			return child;
		}
		
		override protected function createChildren():void
		{
			_skin=_defaultSkin;
			
			_box=new Sprite();
			thisAddChild(_box);
			
			_back=getSkinInstance(getStyleValue("windowBackSkin")) as Sprite;
			_back.width=_width;
			_back.height=_height;
			thisAddChild(_back);
			
			_titleBar=getSkinInstance(getStyleValue("windowTitleSkin")) as Sprite;
			_titleBar.addEventListener(MouseEvent.MOUSE_DOWN,onTitleBarDown);
			_titleBar.width=_width;
			thisAddChild(_titleBar);
			
			_closeBtn=new ButtonBase(this,0,0);
			_closeBtn.addEventListener(MouseEvent.CLICK,onClose);
			_closeBtn.setSize(26,22);
			_closeBtn.move(_width-_closeBtn.width-2,2);
			_closeBtn.skin=_closeBtnSkin;
			thisAddChild(_closeBtn);
			
			_titleText=new TextField();
			_titleText.mouseEnabled=false;
			_titleText.autoSize="left";
			_titleText.multiline=false;
			thisAddChild(_titleText);
			
			thisAddChild(_box);
		
		}
		
		protected function onClose(event:MouseEvent):void
		{
			close();
		}
		
		protected function onTitleBarDown(event:MouseEvent):void
		{
			parent.addChild(this);
			startDrag();
			stage.addEventListener(MouseEvent.MOUSE_UP,onTitleBarUp);
		}		
		
		protected function onTitleBarUp(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP,onTitleBarUp);
			stopDrag();
		}

		/**
		 *窗口标题 
		 */
		public function get title():String
		{
			return _title;
		}

		/**
		 * @private
		 */
		public function set title(value:String):void
		{
			_title = value;
			_titleText.text=value;
			_titleText.x=_width-_titleText.width>>1;
			_titleText.y=2;
		}
		public function close():void
		{
			parent.removeChild(this);
		}
		
	}
}