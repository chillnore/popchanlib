package com.popchan.display.component
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 *格子UI
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class GridUI extends Box
	{
		protected var _disH:Number=0;
		protected var _disV:Number=0;
		protected var _colCount:int=2;
		public function GridUI(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}
		override protected function layout():void
		{
			var child:DisplayObject;
			for(var i:int=0;i<numChildren;i++)
			{
				child=getChildAt(i);
				child.x=i%_colCount*_disH;
				child.y=int(i/_colCount)*_disV;
			}
		}

		/**
		 *垂直间距 
		 */
		public function get disV():Number
		{
			return _disV;
		}

		/**
		 * @private
		 */
		public function set disV(value:Number):void
		{
			_disV = value;
		}

		/**
		 *水平间距 
		 */
		public function get disH():Number
		{
			return _disH;
		}

		/**
		 * @private
		 */
		public function set disH(value:Number):void
		{
			_disH = value;
		}
		/**
		 *列数 
		 */
		public function get colCount():int
		{
			return _colCount;
		}

		public function set colCount(value:int):void
		{
			_colCount = value;
		}

		
	}
}