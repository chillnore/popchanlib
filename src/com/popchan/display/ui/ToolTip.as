package com.popchan.display.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 *提示类 默认用单行文本显示 ，游戏中其他TIP显示，比如装备，道具等继承此类即可
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class ToolTip extends Component implements IToolTip
	{
		protected var _tf:TextField;
		protected var _back:Sprite;
		protected var _maxWidth:int=200;
		protected var _data:Object;
		private var _defaultSkin:Object=
			{
				backSkin:"TooTipBackSkin"
			};
		public function ToolTip(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}
		
		override protected function createChildren():void
		{
			_skin=_defaultSkin;
			
			_tf=new TextField();
			_tf.autoSize="left";
			addChild(_tf);
			
			
		}
		protected function drawBack():void
		{
			if(_back)
				removeChild(_back);
			_back=getSkinInstance(getStyleValue("backSkin")) as Sprite;
			addChildAt(_back,0);
			
		}
		
		override protected function draw():void
		{
			if(isCallLater(CallLaterType.SKIN))
			{
				drawBack();
			}
			if(isCallLater(CallLaterType.SIZE))
			{
				if(_back)
				{
					_back.width=_width;
					_back.height=_height;
				}
			}
			clearCallLater();
		}
		
		
		public function set data(value:Object):void
		{
			_data=value;
			_tf.text=value.toString();
			if(_tf.width>_maxWidth)
			{
				_tf.width=_maxWidth;
				_tf.wordWrap=true;
			}else
			{
				_tf.wordWrap=false;
			}
			setSize(_tf.width,_tf.height);
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function destory():void
		{
			//trace("销毁toolTip")
		}

		/**
		 *最大宽度 
		 */
		public function get maxWidth():int
		{
			return _maxWidth;
		}

		/**
		 * @private
		 */
		public function set maxWidth(value:int):void
		{
			_maxWidth = value;
		}

	}
}