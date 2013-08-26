package com.popchan.display.ui
{
	import com.popchan.display.ui.styles.StyleAssets;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	/**
	 *树组件 简单的树组件,需修改
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	[Event(name="change", type="flash.events.Event")]
	public class Tree extends ScrollPane
	{
		/*父节点数据呈现器*/
		protected var _folderCell:Class=TreeFolderCell;
		/*Item节点数据呈现器*/
		protected var _itemCell:Class=TreeItemCell;
		protected var _showRoot:Boolean;
		protected var _dataProvider:Object;
		protected var _holder:Sprite;
		protected var _recyleCell:Dictionary;
		public var folderRowHeight:int=20;
		public var itemRowHeight:int=20;
		protected var _selectedNode:XML;
		/*默认皮肤*/
		private var _defaultSkin:Object=
			{
				backSkin:"ScrollPaneBackSkin",
				folderClosedIcon:"TreeFolderClosedIcon",
				folderOpenIcon:"TreeFolderOpenIcon"
			};
		public function Tree(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}
		
		override protected function preInit():void
		{
			_recyleCell=new Dictionary();
			_width=200;
			_height=200;
			_skin=_defaultSkin;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			_holder=new Sprite();
			addChild(_holder);
			_hScrollBar.policy=ScrollPolicy.OFF;
			TreeFolderCell.folderClosedIcon=StyleAssets.getClass(String(getStyleValue("folderClosedIcon")));
			TreeFolderCell.folderOpenIcon=StyleAssets.getClass(String(getStyleValue("folderOpenIcon")));
		}
		
		
		/**
		 *是否显示根节点 
		 */
		public function get showRoot():Boolean
		{
			return _showRoot;
		}
		
		/**
		 * @private
		 */
		public function set showRoot(value:Boolean):void
		{
			_showRoot = value;
		}
		
		/**
		 *数据源 
		 */
		public function get dataProvider():Object
		{
			return _dataProvider;
		}
		
		/**
		 * @private
		 */
		public function set dataProvider(value:Object):void
		{
			_dataProvider = value;
			createFolder();
			validateNow();
		}
		

		/**
		 *打开或者关闭分支项目 
		 * @param item
		 * @param open
		 * 
		 */
		public function expandItem(item:Object,open:Boolean):void
		{
			for(var j:int=_holder.numChildren-1;j>=0;j--)
			{
				if((_holder.getChildAt(j) is TreeFolderCell)&&TreeFolderCell(_holder.getChildAt(j)).data==item)
				{
					if(open)
					{
					openFolder(item as XML,TreeFolderCell(_holder.getChildAt(j)));
					
					}else
					{
						closeFolder(item.item);
					}
					setPosition();
					setScrollTarget(_holder);
					break;
				}
			}
		}
		/**
		 *如果指定的项目分支处于打开状态（显示其子项），则返回 true 
		 * @param item
		 * @return 
		 * 
		 */
		public function isItemOpen(item:Object):Boolean
		{
			return false;
		}
		
		protected function createFolder():void
		{
			var xml:XML=_dataProvider as XML;
			var list:XMLList=xml.item;
			
			for(var i:int=0;i<list.length();i++)
			{
				var folder:TreeFolderCell=new _folderCell();
				folder.y=i*20;
				folder.data=list[i];
				_holder.addChild(folder);
				folder.addEventListener(MouseEvent.CLICK,onFolderClick);
			}
		}
		
		protected function onFolderClick(event:MouseEvent):void
		{
			var folder:TreeFolderCell=event.currentTarget as TreeFolderCell;
			var node:XML=folder.data as XML;
			_selectedNode=node;
			dispatchEvent(new Event(Event.CHANGE));
			if(folder.isOpen)
			{
				folder.isOpen=false;
				closeFolder(node.item);
				
			}else
			{
				openFolder(node,folder);
				
			}
			
			setPosition();
			setScrollTarget(_holder);
		}
		/**
		 *打开父节点 
		 * @param node
		 * @param folder
		 * 
		 */
		protected function openFolder(node:XML,folder:TreeFolderCell):void
		{
			
			folder.isOpen=true;
			var index:int=_holder.getChildIndex(folder);
			for(var i:int=0;i<node.item.length();i++)
			{
				
				if(node.item[i].children().length()>0)
				{
					var folder1:TreeFolderCell=new _folderCell();
					folder1.x=folder.x+16;
					folder1.data=node.item[i];
					_holder.addChildAt(folder1,index+1);
					folder1.addEventListener(MouseEvent.CLICK,onFolderClick);
				}else
				{
					var item:TreeItemCell;
					item=new _itemCell();
					item.x=folder.x+16;
					item.data=node.item[i];
					item.addEventListener(MouseEvent.CLICK,onItemClick);
					_holder.addChildAt(item,index+1);
				}
				
			}
		}
		
		protected function onItemClick(event:MouseEvent):void
		{
			var item:TreeItemCell=event.currentTarget as TreeItemCell;
			_selectedNode=item.data as XML;
			dispatchEvent(new Event(Event.CHANGE));
		}
		/**
		 *关闭选中的节点下面的子节点 
		 * @param node
		 * @param folder
		 * 
		 */
		protected function closeFolder(node:XMLList):void
		{
			folder=[];
			nodes=[];
			getChildNodes(node);
			
			for(var i:int=0;i<nodes.length;i++)
			{
				for(var j:int=_holder.numChildren-1;j>=0;j--)
				{
					if((_holder.getChildAt(j) is TreeItemCell)&&TreeItemCell(_holder.getChildAt(j)).data==nodes[i])
					{
						TreeItemCell(_holder.getChildAt(j)).removeEventListener(MouseEvent.CLICK,onItemClick);
						_holder.removeChildAt(j);
						break;
					}else if((_holder.getChildAt(j) is TreeFolderCell)&&TreeFolderCell(_holder.getChildAt(j)).data==nodes[i])
					{
						TreeFolderCell(_holder.getChildAt(j)).removeEventListener(MouseEvent.CLICK,onFolderClick);
						_holder.removeChildAt(j);
						break;
					}
				}
			}
		}
		private var nodes:Array=[];
		private var folder:Array=[];
		/**
		 *获取list下面的节点 
		 * @param list
		 * @return 
		 * 
		 */
		protected function getChildNodes(list:XMLList):void
		{
			var len:int=list.length();
			for(var i:int=0;i<len;i++)
			{
				if(list[i].children().length()>0)
				{
					folder.push(list[i]);
					nodes.push(list[i]);
				}else
				{
					
					nodes.push(list[i]);
				}
				
			}	
			if(folder.length>0)
				getChildNodes(folder.pop().item);
		}
		/**
		 *设置Item的位置 
		 * 
		 */
		protected function setPosition():void
		{
			var offset:int=0;
			for(var i:int=0;i<_holder.numChildren;i++)
			{
				_holder.getChildAt(i).y=offset;
				if(_holder.getChildAt(i) is TreeFolderCell)
				{
					offset+=folderRowHeight;
				}else
				{
					offset+=itemRowHeight;
				}
			}
		}

		public function get folderCell():Class
		{
			return _folderCell;
		}

		public function set folderCell(value:Class):void
		{
			_folderCell = value;
		}

		public function get itemCell():Class
		{
			return _itemCell;
		}

		public function set itemCell(value:Class):void
		{
			_itemCell = value;
		}

		/**
		 *选中的节点 
		 * @return 
		 * 
		 */
		public function get selectedNode():XML
		{
			return _selectedNode;
		}
		
		
	}
}