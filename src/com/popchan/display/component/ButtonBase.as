package com.popchan.display.component
{
	
	import com.popchan.manager.ResourceManager;
	import com.popchan.utils.BitmapUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
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
		protected var _back:Bitmap;
		/*皮肤映射*/
		protected var _skinMap:Object={up:0,over:1,down:2,disabled:0};
		protected var _skinRowCount:int=1;
		protected var _skinColCount:int=3;
		protected var _tiles:Array=[];
		protected var _tilesCopy:Array=[];
		protected var _scale9:String="6,7,14,8";
		
		public function ButtonBase(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skinName:String="Skin_button")
		{
			super(parent, x, y);
			this.skin=skinName;
		}
		
		override protected function config():void
		{
			setSize(64,28);
			
			buttonMode=true;
			useHandCursor=true;
			mouseChildren=false;
			
			setupListener();
			_timer=new Timer(50,0);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			changeMouseState(MOUSE_UP);
			
			_back=new Bitmap();
			addChild(_back);
		}
		
		override public function set skin(value:String):void
		{
			if(value!=null)
			{
				_skin=value;
				_tiles=ResourceManager.getBitmapClips(value,_skinRowCount,_skinColCount);
				
				_tilesCopy=_tiles.concat([]);
				invalidate(CallLaterEnum.SIZE);
				invalidate(CallLaterEnum.SKIN);
			}
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
				invalidate(CallLaterEnum.SKIN);
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
			if(_skinMap.hasOwnProperty(styleName))
				_back.bitmapData=_tiles[_skinMap[styleName]];
		}
		/**
		 *改变大小 
		 * 
		 */
		protected function changeBgSzie():void
		{
			if(_scale9==null)return;
			_tiles=[];
			for(var i:int=0;i<_tilesCopy.length;i++)
			{
				_tiles.push(BitmapUtil.scaleGrid9Bmd(_tilesCopy[i],_scale9.split(","),_width,_height));
			}
		}
		
		override protected function draw():void
		{
			if(isCallLater(CallLaterEnum.SIZE))
			{
				changeBgSzie();
				invalidate(CallLaterEnum.SKIN,false);
			}
			if(isCallLater(CallLaterEnum.SKIN))
			{
				drawBg();
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
		
		/**
		 *九宫格 1，2，3，4 left,top,right,bottom 
		 */
		public function get scale9():String
		{
			return _scale9;
		}
		
		/**
		 * @private
		 */
		public function set scale9(value:String):void
		{
			_scale9 = value;
			invalidate(CallLaterEnum.SIZE);
		}

		public function get skinRowCount():int
		{
			return _skinRowCount;
		}

		public function set skinRowCount(value:int):void
		{
			_skinRowCount = value;
		}

		public function get skinColCount():int
		{
			return _skinColCount;
		}

		public function set skinColCount(value:int):void
		{
			_skinColCount = value;
		}
		/**
		 *获取皮肤tile的宽度 
		 * @return 
		 * 
		 */
		public function get tileWidth():int
		{
			return getSkinSize(_skin).x/_skinColCount;
		}
		/**
		 *获取皮肤tile的高度 
		 * @return 
		 * 
		 */
		public function get tileHeight():int
		{
			return getSkinSize(_skin).y/_skinRowCount;
		}
		
	}
}