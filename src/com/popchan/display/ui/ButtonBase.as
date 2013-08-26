package com.popchan.display.ui
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 *按钮基类  
	 * 	公共属性
	 * 			1.autoRepeat 当鼠标按下的时候是否一直分发ButtonDown事件
	 * 			1.repeatDelay 第一次延迟多少毫秒分发buttonDown事件
	 * 			2.repeatInterval 多少毫秒分发一次buttonDown事件
	 * 	公共方法
	 * 	样式
	 * 		1.upSkin,overSkin,downSkin,disabledSkin
	 *  事件
	 * 		1.ComponentEvent.BUTTON_DOWN 按钮按下
	 * 
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	[Event(name="buttonDown", type="com.popchan.display.ui.ComponentEvent")]
	public class ButtonBase extends Component
	{
		protected var _timer:Timer;
		protected var _repeatDelay:Number=500;
		protected var _repeatInterval:Number=35;
		protected var _autoRepeat:Boolean;
		
		protected var _mouseState:String;
		public static const MOUSE_UP:String="up";
		public static const MOUSE_OVER:String="over";
		public static const MOUSE_DOWN:String="down";
		protected var _back:DisplayObject;
		/*默认皮肤*/ 
		private var _defaultSkin:Object=
			{
				upSkin:"ButtonUp",
				overSkin:"ButtonOver",
				downSkin:"ButtonDown",
				disabledSkin:"ButtonDisabled"
			};
		/*皮肤映射w*/
		private var _skinMap:Object={up:0,over:1,down:2,disabled:3};
		
		public function ButtonBase(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}
		
		override protected function preInit():void
		{
			_skin=_defaultSkin;
			_width=80;
			_height=24;
			buttonMode=true;
			useHandCursor=true;
			mouseChildren=false;
			setupListener();
			_timer=new Timer(50,0);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			changeMouseState(MOUSE_UP);
		}
		private function setupListener():void
		{
			addEventListener(MouseEvent.MOUSE_DOWN,mouseHandler);
			addEventListener(MouseEvent.MOUSE_UP,mouseHandler);
			addEventListener(MouseEvent.ROLL_OUT,mouseHandler);
			addEventListener(MouseEvent.ROLL_OVER,mouseHandler);
		}
		protected function mouseHandler(event:MouseEvent):void
		{
			switch(event.type)
			{
				case MouseEvent.MOUSE_DOWN:
					changeMouseState(MOUSE_DOWN);
					startRepeat();
					break;
				case MouseEvent.MOUSE_UP:
					changeMouseState(MOUSE_OVER);
					stopRepeat();
					break;
				case MouseEvent.ROLL_OUT:
					changeMouseState(MOUSE_UP);
					stopRepeat();
					break;
				case MouseEvent.ROLL_OVER:
					changeMouseState(MOUSE_OVER);
					stopRepeat();
					break;
			}
			
		}
		protected function startRepeat():void
		{
			if(_autoRepeat)
			{
				_timer.delay=_repeatDelay;
				_timer.start();
			}
			dispatchEvent(new ComponentEvent(ComponentEvent.BUTTON_DOWN, true));
		}
		protected function stopRepeat():void
		{
			_timer.reset();
		}
		protected function timerHandler(event:TimerEvent):void
		{
			if(!_autoRepeat)
			{
				stopRepeat();
				return;
			}
			if(_timer.currentCount==1)
				_timer.delay=_repeatInterval;
			dispatchEvent(new ComponentEvent(ComponentEvent.BUTTON_DOWN,true));
		}
		/**
		 *切换状态 
		 * @param value
		 * 
		 */
		private function changeMouseState(value:String):void
		{
			if(_mouseState!=value)
			{
				_mouseState=value;
				invalidate(CallLaterType.SKIN);
			}
		}
		/**
		 *绘制背景 
		 * 
		 */
		protected function drawBg():void
		{
			var bg:DisplayObject=_back;
			var styleName:String=_enabled?_mouseState:"disabled";
			styleName+="Skin";
			_back=getSkinInstance(getStyleValue(styleName));
			addChildAt(_back,0);
			if(bg&&bg!=_back)
			{
				removeChild(bg);
				bg=null;
			}
		}
		/**
		 *改变大小 
		 * 
		 */
		protected function changeBgSzie():void
		{
			if(_back)
			{
				_back.width=_width;
				_back.height=_height;
			}
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
			}
			super.draw();
		}
		/**
		 *指定在用户按住鼠标按键时是否重复分派 buttonDown 事件 
		 * @return 
		 * 
		 */
		public function get autoRepeat():Boolean
		{
			return _autoRepeat;
		}
		
		public function set autoRepeat(value:Boolean):void
		{
			_autoRepeat = value;
		}
		
		public function get repeatDelay():Number
		{
			return _repeatDelay;
		}
		
		public function set repeatDelay(value:Number):void
		{
			_repeatDelay = value;
		}
		
		public function get repeatInterval():Number
		{
			return _repeatInterval;
		}
		
		public function set repeatInterval(value:Number):void
		{
			_repeatInterval = value;
		}	
	}
}