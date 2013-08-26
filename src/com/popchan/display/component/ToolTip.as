package com.popchan.display.component
{
	import com.popchan.manager.ResourceManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 *提示类 默认用单行文本显示
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class ToolTip extends Component implements IToolTip
	{
		protected var _tf:TextField;
		protected var _back:Image;
		protected var _data:Object;
		protected var _scale9:String="23,6,67,16";
		// left top right bottom 
		protected var _padding:String="6,6,6,6";
		public function ToolTip(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skin:String="Skin_tooltip")
		{
			super(parent, x, y);
			this.skin=skin;
		}
		
		override protected function config():void
		{
			mouseChildren=mouseEnabled=false;
			
			_back=new Image(this);
			_back.scale9=_scale9;
			
			_tf=new TextField();
			_tf.autoSize="left";
			_tf.multiline=true;
			_tf.wordWrap=false;
			addChild(_tf);
		}
		
		override public function set skin(value:String):void
		{
			_skin=value;
			_back.bitmapData=ResourceManager.getBitmapData(_skin);
		}
		
		
		public function set data(value:Object):void
		{
			_data=value;
			_tf.htmlText=value.toString();
			
			
			var pad:Array=_padding.split(",");
			_back.width=_tf.width+int(pad[0])+int(pad[2]);
			_back.height=_tf.height+int(pad[1])+int(pad[3]);
			
			_tf.x=pad[0];
			_tf.y=pad[1];
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function destory():void
		{
			//trace("销毁toolTip")
		}
		
		public function get scale9():String
		{
			return _scale9;
		}
		
		public function set scale9(value:String):void
		{
			_scale9 = value;
			_back.scale9=_scale9;
			invalidate(CallLaterEnum.SIZE);
		}
		/**
		 *设置边界 
		 * 
		 */
		public function setLocation():void
		{
			if(x<0)
				x=0;
			else if(x+_back.width>parent.stage.stageWidth)
				x=parent.stage.stageWidth-_back.width;
			if(y<0)
				y=0;
			else if(y+_back.height>parent.stage.stageHeight)
				y=parent.stage.stageHeight-_back.height;
		}

		public function get padding():String
		{
			return _padding;
		}

		public function set padding(value:String):void
		{
			_padding = value;
			
		}

		
	}
}