package com.popchan.display.component
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 *水平布局
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class HBox extends Box
	{
		protected var _gap:int=6;
		protected var _horizontalAlign:String="left";
		protected var _verticalAlign:String="top";
		public function HBox(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}
		
		override protected function config():void
		{
			_width=200;
			_height=200;
		}
		
		
		
		
		override protected function layout():void
		{
			trace("布局")
			//先计算宽度，便于排列
			var offsetX:int;
			var i:int;
			var child:DisplayObject;
			var contentWidth:int;
			for(i=0;i<numChildren;i++)
			{
				child=getChildAt(i);
				child.x=offsetX;
				offsetX+=child.width+_gap;
				contentWidth+=child.width;
			}
			contentWidth+=(numChildren-1)*_gap;
			
			
			offsetX=0;
			for(i=0;i<numChildren;i++)
			{
				child=getChildAt(i);
				//水平位置
				if(_horizontalAlign=="left")
				{
					child.x=offsetX;
					offsetX+=child.width+_gap;
				}else if(_horizontalAlign=="center")
				{
					if(i==0)
					{
						offsetX=_width-contentWidth>>1;
					}
					child.x=offsetX;
					offsetX+=child.width+_gap;
				}else if(_horizontalAlign=="right")
				{
					if(i==0)
					{
						offsetX=_width-contentWidth;
					}
					child.x=offsetX;
					offsetX+=child.width+_gap;
				}
				//垂直位置
				if(_verticalAlign=="top")
				{
					child.y=0;
				}else if(_verticalAlign=="middle")
				{
					child.y=_height-child.height>>1;
				}else if(_verticalAlign=="bottom")
				{
					child.y=_height-child.height;
				}
			}
		}

		/**
		 *水平对齐位置 left center right
		 */
		public function get horizontalAlign():String
		{
			return _horizontalAlign;
		}

		/**
		 * @private
		 */
		public function set horizontalAlign(value:String):void
		{
			_horizontalAlign = value;
			invalidate(CallLaterEnum.SIZE);
		}

		/**
		 *垂直对齐位置top middle bottom 
		 */
		public function get verticalAlign():String
		{
			return _verticalAlign;
		}

		/**
		 * @private
		 */
		public function set verticalAlign(value:String):void
		{
			_verticalAlign = value;
			invalidate(CallLaterEnum.SIZE);
		}

		/**
		 *间距 
		 */
		public function get gap():int
		{
			return _gap;
		}

		/**
		 * @private
		 */
		public function set gap(value:int):void
		{
			_gap = value;
			invalidate(CallLaterEnum.SIZE);
		}
		
		
	}
}