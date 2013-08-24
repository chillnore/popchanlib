package com.popchan.algorithm.findpath
{
	import flash.utils.getTimer;
	
	/**
	 *二叉堆 用于优化寻路
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class BinaryHeap
	{
		private var _data:Array;
		private var _sortField:String;
		/**
		 *
		 * @param sortField 用于比较的字段
		 * 
		 */
		public function BinaryHeap(sortField:String=null)
		{
			_data=[];
			_sortField=sortField;
		}
		/**
		 *放入堆中 
		 * @param value
		 * 
		 */
		public function push(value:Object):void
		{
			var pos:int=_data.push(value);
			while(pos>1)
			{
				var parentPos:int=pos>>1;
				if(compare(_data[pos-1],_data[parentPos-1]))
				{
					var temp:Object=_data[pos-1];
					_data[pos-1]=_data[parentPos-1];
					_data[parentPos-1]=temp;
					pos=parentPos;
				}else
				{
					break;
				}
			}
			//trace("cost"+(getTimer()-t))
		}
		/**
		 *取出第一个数 
		 * @return 
		 * 
		 */
		public function shift():Object
		{
			//取出第一个，将末尾的数移到最前，然后和子树比较
			var value:Object=_data.shift();
			var len:int=_data.length;
			if(len==1)
				return value;
			_data.unshift(_data.pop());
			var pos:int=1;
			while(true)
			{
				var leftPos:int=pos*2;
				var rightPos:int=leftPos+1;
				var min:int=pos;
				if(leftPos<len)
				{
					if(compare(_data[pos-1],_data[leftPos-1]))
					{
						min=leftPos;
					};
					if(rightPos<len&&compare(_data[rightPos-1],_data[min-1]))
						min=rightPos;
					
				}
				if(min!=pos)
				{
					var temp:Object=_data[pos-1];
					_data[pos-1]=_data[min-1];
					_data[min-1]=temp;
					pos=min;
				}else
				{
					break;
				}
			}
			return value;
		}
		/**
		 * 更新位置
		 * @param value
		 * 
		 */
		public function update(value:Object):void
		{
			var pos:int=_data.indexOf(value)+1;
			if(pos!=0)
			{
				while(pos>1)
				{
					var parentPos:int=pos>>1;
					if(compare(_data[pos-1],_data[parentPos-1]))
					{
						var temp:Object=_data[pos-1];
						_data[pos-1]=_data[parentPos-1];
						_data[parentPos-1]=temp;
						pos=parentPos;
					}else
					{
						break;
					}
				}	
			}
		}
		/**
		 *比较对象的大小  a是否小于b
		 * @param a
		 * @param b
		 * @return 
		 * 
		 */
		private function compare(a:Object,b:Object):Boolean
		{
			if(_sortField!=null)
			{
				return int(a[_sortField])<int(b[_sortField]);
			}else
			{
				return int(a)<int(b);
			}
			return false;
		}
		
		public function indexOf(value:Object):int
		{
			return _data.indexOf(value);
		}
		public function get length():int
		{
			return _data.length;
		}
		public function get data():Array
		{
			return _data;
		}
	}
}