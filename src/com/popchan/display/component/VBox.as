package com.popchan.display.component
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 *垂直布局容器
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class VBox extends Box
	{
		protected var _gap:int=6;
		protected var _horizontalAlign:String="left";
		protected var _verticalAlign:String="top";
		public function VBox(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
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
			//先计算宽度，便于排列
			var offsetY:int;
			var i:int;
			var child:DisplayObject;
			var contentHeight:int;
			for(i=0;i<numChildren;i++)
			{
				child=getChildAt(i);
				child.y=offsetY;
				offsetY+=child.height+_gap;
				contentHeight+=child.height;
			}
			contentHeight+=(numChildren-1)*_gap;
			
			
			offsetY=0;
			for(i=0;i<numChildren;i++)
			{
				child=getChildAt(i);
				//垂直位置
				if(_verticalAlign=="top")
				{
					child.x=offsetY;
					offsetY+=child.height+_gap;
				}else if(_verticalAlign=="middle")
				{
					if(i==0)
					{
						offsetY=_height-contentHeight>>1;
					}
					child.y=offsetY;
					offsetY+=child.height+_gap;
				}else if(_verticalAlign=="bottom")
				{
					if(i==0)
					{
						offsetY=_height-contentHeight;
					}
					child.y=offsetY;
					offsetY+=child.height+_gap;
				}
				//水平位置
				if(_horizontalAlign=="left")
				{
					child.x=0;
				}else if(_horizontalAlign=="center")
				{
					child.x=_width-child.width>>1;
				}else if(_horizontalAlign=="right")
				{
					child.x=_width-child.width;
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