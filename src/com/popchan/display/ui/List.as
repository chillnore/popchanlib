package com.popchan.display.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	/**
	 *列表组件 垂直方向
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	[Event(name="select", type="flash.events.Event")]
	public class List extends Component
	{
		protected var _dataProvider:Array=[];
		protected var _itemBox:Sprite;
		protected var _rowHeight:Number=20;
		protected var _scrollBar:VScrollBar;
		protected var _selectedIndex:int=-1;
		protected var _selectedItem:Object;
		protected var _itemClass:Class=ListCell;
		/*存储已经有数据的cell*/
		protected var _hasDataCells:Array=[];
		/*可循环利用的cell*/
		protected var _recycleCells:Array=[];
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
				_scrollBar.x=_width-_scrollBar.width;
				_scrollBar.setThumbPercent(_height/(_dataProvider.length*_rowHeight));
				_scrollBar.pageScrollSize=Math.floor(_height/_rowHeight);
				_scrollBar.maximum=Math.max(0,_dataProvider.length-_scrollBar.pageScrollSize);
				_scrollBar.minimum=0;
				_scrollBar.height=_height;
				_scrollBar.validateNow();
				_itemBox.scrollRect=new Rectangle(0,0,_width,_height);
				scrollToIndex(_selectedIndex);
				invalidate(CallLaterType.DATA,false);
			}
			if(isCallLater(CallLaterType.DATA))
			{
				drawItems();
			}
			clearCallLater();
		}
		
		
		protected function onScrollBarChange(event:Event):void
		{
			drawItems();
		}		
		/**
		 *设置Item的数据 
		 * 
		 */
		protected function drawItems():void
		{
			var rect:Rectangle=_itemBox.scrollRect;
			var offset:int=_scrollBar.value;
			rect.y=Math.floor(_scrollBar.value*_rowHeight%rowHeight);
			_itemBox.scrollRect=rect;
			
			var itemCount:int=Math.ceil(_height/_rowHeight);
			itemCount=Math.min(itemCount+1,_dataProvider.length);
			
			var startIndex:int=offset;
			var endIndex:int=Math.min(offset+itemCount,_dataProvider.length);
			var i:int;
			var cellHash:Dictionary=new Dictionary(true);
			var cell:ListCell;
			var cellToRender:Dictionary=new Dictionary(true);
			var cellData:Object;
			//将要填充的items
			for(i=startIndex;i<endIndex;i++)
			{
				cellHash[_dataProvider[i]]=true;
			}
			while(_hasDataCells.length>0)
			{
				cell=_hasDataCells.pop();
				if(cellHash[cell.data]==null)
				{
					_recycleCells.push(cell);
				}else
				{
					cellToRender[cell.data]=cell;
				}
				cell.selected=false;
				_itemBox.removeChild(cell);
				delete cellHash[cell.data];
			}
			
			for(i=startIndex;i<endIndex;i++)
			{
				cellData=_dataProvider[i];
				if(cellToRender[cellData])
				{
					cell=cellToRender[cellData];
				}else if(_recycleCells.length>0)
				{
					cell=_recycleCells.pop();
					cell.data=cellData;
				}else
				{
					cell=new _itemClass();
					cell.setSize(_width,_rowHeight);
					cell.addEventListener(MouseEvent.CLICK,onSelect);
					cell.data=cellData;
					
				}
				if(i==_selectedIndex)
					cell.selected=true;
				else
					cell.selected=false;
				_hasDataCells.push(cell);
				cell.x=0;
				cell.y=(i-offset)*_rowHeight;
				
				_itemBox.addChild(cell);

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
			if(index>=0&&index<_dataProvider.length)
			{
				_scrollBar.value=index;
				drawItems();
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
			_dataProvider.push(item);
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
			_dataProvider.splice(index,0,item);
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
			var index:int=_dataProvider.indexOf(item);
			if(index!=-1)
			{
				_dataProvider.splice(index,1);
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
			if(index>=0&&index<_dataProvider.length)
			{
				_dataProvider.splice(index,1);
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
			_dataProvider=[];
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
			drawItems();
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
				if(value>=0&&value<_dataProvider.length)
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
			if(_selectedIndex>=0&&_selectedIndex<_dataProvider.length)
				return _dataProvider[_selectedIndex];
			return null;
		}

		public function set selectedItem(value:Object):void
		{
			_selectedItem = value;
			var index:int=_dataProvider.indexOf(_selectedItem);
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
			return _dataProvider;
		}

		/**
		 * @private
		 */
		public function set dataProvider(value:Array):void
		{
			_dataProvider = value;
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