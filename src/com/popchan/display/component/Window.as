package com.popchan.display.component
{
	import com.popchan.manager.ResourceManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	/**
	 *窗口类
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class Window extends Component
	{
		protected var _title:String="";
		protected var _minimizable:Boolean;
		protected var _maximizable:Boolean;
		protected var _back:Image;
		protected var _maxBtn:ButtonBase;
		protected var _minBtn:ButtonBase;
		protected var _closeBtn:ButtonBase;
		protected var _titleLabel:Label;
		/*窗口内容*/
		public var content:Sprite;
		protected var _dragable:Boolean;
		public function Window(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skin:String="Skin_window")
		{
			super(parent, x, y);
			this.skin=skin;
		}
		
		override protected function config():void
		{
			setSize(200,200);
			_back=new Image(this);
			_maxBtn=new ButtonBase(this,0,0,null);
			_minBtn=new ButtonBase(this,0,0,null);
			_closeBtn=new ButtonBase(this,0,0,null);
			
			_titleLabel=new Label("窗口标题",this);
		}
		
		override protected function draw():void
		{
			if(isCallLater(CallLaterEnum.SKIN))
			{
				_back.bitmapData=ResourceManager.getBitmapData(_skin);
				_back.validateNow();
				
				_maxBtn.skin=_skin+"_max";
				_maxBtn.setSize(_maxBtn.tileWidth,_maxBtn.tileHeight);
				_maxBtn.validateNow();
				
				
				_minBtn.skin=_skin+"_min";
				_minBtn.setSize(_minBtn.tileWidth,_minBtn.tileHeight);
				_minBtn.validateNow();
				
				
				_closeBtn.skin=_skin+"_close";
				_closeBtn.setSize(_closeBtn.tileWidth,_closeBtn.tileHeight);
				_closeBtn.validateNow();
				
			}
			if(isCallLater(CallLaterEnum.SIZE))
			{
				_closeBtn.move(_width-_closeBtn.width-2,1);
				_maxBtn.move(_closeBtn.x-_maxBtn.width-2,1);
				_minBtn.move(_maxBtn.x-_minBtn.width-2,1);
			}
		}
		
		
	
		/**
		 *关闭 
		 * 
		 */
		public function close():void
		{
			
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
		}

		/**
		 *窗口是否可以最小化 
		 */
		public function get minimizable():Boolean
		{
			return _minimizable;
		}

		/**
		 * @private
		 */
		public function set minimizable(value:Boolean):void
		{
			_minimizable = value;
		}

		/**
		 *窗口是否可以最大化 
		 */
		public function get maximizable():Boolean
		{
			return _maximizable;
		}

		/**
		 * @private
		 */
		public function set maximizable(value:Boolean):void
		{
			_maximizable = value;
		}

		/**
		 *是否可以拖动 
		 */
		public function get dragable():Boolean
		{
			return _dragable;
		}

		/**
		 * @private
		 */
		public function set dragable(value:Boolean):void
		{
			_dragable = value;
		}


	}
}