package com.popchan.display.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 *列表组件 垂直方向
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	[Event(name="select", type="flash.events.Event")]
	public class List extends Component
	{
		protected var _items:Array=[];
		protected var _itemBox:Sprite;
		protected var _rowHeight:Number=20;
		protected var _scrollBar:VScrollBar;
		protected var _selectedIndex:int=-1;
		protected var _selectedItem:Object;
		protected var _itemClass:Class=ListCell;
		public function List(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}
		
		override protected function preInit():void
		{
			setSize(100,200);
			this.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
		}
		
		override protected function createChildren():void
		{
			_itemBox=new Sprite();
			this.addChild(_itemBox);
			_itemBox.scrollRect=new Rectangle(0,0,_width,_height);
			_scrollBar=new VScrollBar(this,0,0);
			_scrollBar.addEventListener(Event.CHANGE,onScrollBarChange);
			

		}
		
		override protected function draw():void
		{
			if(isCallLater(CallLaterType.SIZE))
			{
				createItems();
				
				_scrollBar.x=_width-_scrollBar.width;
				_scrollBar.setThumbPercent(_height/(_items.length*_rowHeight));
				_scrollBar.pageScrollSize=Math.floor(_height/_rowHeight);
				_scrollBar.maximum=Math.max(0,_items.length-_scrollBar.pageScrollSize);
				_scrollBar.minimum=0;
				_scrollBar.height=_height;
				_scrollBar.validateNow();
				_itemBox.scrollRect=new Rectangle(0,0,_width,_height);
				scrollToIndex(_selectedIndex);
				invalidate(CallLaterType.DATA,false);
			}
			if(isCallLater(CallLaterType.DATA))
			{
				updateItemsData();
			}
			clearCallLater();
		}
		
		
		protected function onScrollBarChange(event:Event):void
		{
			updateItemsData();
		}		
		
		/**
		 *创建Items 
		 * 
		 */
		protected function createItems():void
		{
			var cell:ListCell;
			while(_itemBox.numChildren>0)
			{
				cell=ListCell(_itemBox.getChildAt(0));
				cell.removeEventListener(MouseEvent.CLICK,onSelect);
				_itemBox.removeChild(cell);
			}
			//计算Items的个数
			var itemCount:int=Math.ceil(_height/_rowHeight);
			itemCount=Math.min(itemCount+1,_items.length);
			itemCount=Math.max(1,itemCount);
			for(var i:int=0;i<itemCount;i++)
			{
				cell=new _itemClass(_itemBox,0,i*_rowHeight);
				cell.setSize(_width,_rowHeight);
				cell.addEventListener(MouseEvent.CLICK,onSelect);
			}
		}
		/**
		 *设置Item的数据 
		 * 
		 */
		protected function updateItemsData():void
		{
			var rect:Rectangle=_itemBox.scrollRect;
			var offset:int=_scrollBar.value;
			rect.y=Math.floor(_scrollBar.value*_rowHeight%rowHeight);
			_itemBox.scrollRect=rect;
			
			var itemCount:int=Math.ceil(_height/_rowHeight);
			itemCount=Math.min(itemCount+1,_items.length);
			for(var i:int=0;i<itemCount;i++)
			{
				var item:ListCell=_itemBox.getChildAt(i) as ListCell;
				item.index=i+offset;
				if(offset+i<_items.length)
					item.data=_items[offset+i];
				else
					item.data="";
				if(offset+i==_selectedIndex)
					item.selected=true;
				else
					item.selected=false;
			}
		}
		/**
		 *滚动到指定位置 
		 * @param index
		 * @return 
		 * 
		 */
		public function scrollToIndex(index:int):Boolean
		{
			if(index>=0&&index<_items.length)
			{
				_scrollBar.value=index;
				updateItemsData();
				return true;
			}
			return false;
		}
		/**
		 *添加Item 
		 * @param item
		 * 
		 */
		public function addItem(item:Object):void
		{
			_items.push(item);
			invalidate(CallLaterType.SIZE);
			invalidate(CallLaterType.DATA);
		}
		/**
		 *添加Item到指定位置 
		 * @param item
		 * @param index
		 * 
		 */
		public function addItemAt(item:Object,index:int):void
		{
			_items.splice(index,0,item);
			invalidate(CallLaterType.SIZE);
			invalidate(CallLaterType.DATA);
		}
		/**
		 *移出Item 
		 * @param item
		 * 
		 */
		public function removeItem(item:Object):void
		{
			var index:int=_items.indexOf(item);
			if(index!=-1)
			{
				_items.splice(index,1);
				invalidate(CallLaterType.SIZE);
				invalidate(CallLaterType.DATA);
			}
		}
		/**
		 *移出指定位置的Item 
		 * @param index
		 * 
		 */
		public function removeItemAt(index:int):void
		{
			if(index>=0&&index<_items.length)
			{
				_items.splice(index,1);
				invalidate(CallLaterType.SIZE);
				invalidate(CallLaterType.DATA);
			}
		}
		/**
		 *移出所有 
		 * 
		 */
		public function removeAll():void
		{
			_items=[];
			invalidate(CallLaterType.SIZE);
			invalidate(CallLaterType.DATA);
		}
		
		private function onSelect(e:MouseEvent):void
		{
			var item:ListCell=e.currentTarget as ListCell;
			if(_selectedItem==item.data)return;
			var offset:int=_scrollBar.value;
			for(var i:int=0;i<_itemBox.numChildren;i++)
			{
				if(item==_itemBox.getChildAt(i))
				{
					_selectedIndex=offset+i;
				}
				ListCell(_itemBox.getChildAt(i)).selected=false;
			}
			item.selected=true;
			dispatchEvent(new Event(Event.SELECT));
		}
		
		/**
		 *滚轮处理 
		 * @param event
		 * 
		 */
		protected function onMouseWheel(event:MouseEvent):void
		{
			_scrollBar.value-=event.delta;
			updateItemsData();
		}		
		
		public function get itemClass():Class
		{
			return _itemClass;
		}
		
		/**
		 *提供渲染的Class 
		 * @param value
		 * 
		 */
		public function set itemClass(value:Class):void
		{
			_itemClass = value;
		}

		public function get selectedIndex():int
		{
			return _selectedIndex;
		}

		public function set selectedIndex(value:int):void
		{
			if(value!=_selectedIndex)
			{
				if(value>=0&&value<_items.length)
				{
					_selectedIndex=value;
				}else
				{
					_selectedIndex=-1;
				}
				scrollToIndex(_selectedIndex);
				dispatchEvent(new Event(Event.SELECT));
			}
		}

		public function get selectedItem():Object
		{
			if(_selectedIndex>=0&&_selectedIndex<_items.length)
				return _items[_selectedIndex];
			return null;
		}

		public function set selectedItem(value:Object):void
		{
			_selectedItem = value;
			var index:int=_items.indexOf(_selectedItem);
			if(index!=-1)
			{
				selectedIndex=index;
			}
		}

		public function get rowHeight():Number
		{
			return _rowHeight;
		}

		public function set rowHeight(value:Number):void
		{
			if(value!=_rowHeight)
			{
				_rowHeight = value;
				invalidate(CallLaterType.SIZE);
				invalidate(CallLaterType.DATA);
			}
		}

		/**
		 *数据源 
		 */
		public function get dataProvider():Array
		{
			return _items;
		}

		/**
		 * @private
		 */
		public function set dataProvider(value:Array):void
		{
			_items = value;
			invalidate(CallLaterType.SIZE);
			invalidate(CallLaterType.DATA);
		}
		/**
		 *垂直滚动条显示策略 
		 * @param value
		 * 
		 */
		public function set verticalScrollPolicy(value:String):void
		{
			_scrollBar.policy=value;
			invalidate(CallLaterType.SIZE);
		}
	}
}