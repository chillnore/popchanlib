package com.popchan.algorithm.findpath
{
	import flash.utils.getTimer;

	/**
	 *A*寻路
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class AStar
	{
		private static var _instance:AStar;
		private var _startNode:AStarNode;
		private var _endNode:AStarNode;
		private var _grid:AstarGrid;
		/**开放列表*/
		private var _openList:BinaryHeap;
		/**封闭列表*/
		private var _closeList:Array;
		/**寻找到的路径*/
		private var _path:Array;
		private static const _sqrt2:Number=1.414;
		private var _straightCost:Number=1.0; //直线代价 
		public function AStar()
		{
		}
		public static function get instance():AStar
		{
			if(_instance==null)
				_instance=new AStar();
			return _instance;
		}
		/**
		 * 寻路
		 * @param grid
		 * @return 
		 * 
		 */
		public function findPath(grid:AstarGrid):Array
		{
			/**初始化*/
			_grid=grid;
			_startNode=grid.startNode;
			_endNode=grid.endNode;
			_closeList=[];
			_openList=new BinaryHeap("f");
			_path=[];
			var t:int=getTimer();
			search();
			trace(getTimer()-t);
			return _path;
		}
		private function search():void
		{
			/**从起点开始，遍历每个节点周围的8个节点，找出离结束点代价最小的，再继续遍历，直到结束点*/
			var _tempNode:AStarNode;
			_tempNode=_startNode;
			_closeList.push(_tempNode);
			while(_tempNode!=_endNode)
			{
				
				var sx:int=Math.max(0,_tempNode.x-1);
				var ex:int=Math.min(_grid.rowNum-1,_tempNode.x+1);
				var sy:int=Math.max(0,_tempNode.y-1);
				var ey:int=Math.min(_grid.colNum-1,_tempNode.y+1);
				for(var x:int=sx;x<=ex;x++)
				{
					for(var y:int=sy;y<=ey;y++)
					{
						var testNode:AStarNode=_grid.getNode(x,y);
						if(!testNode.walkable||testNode==_tempNode||!_grid.getNode(testNode.x,_tempNode.y).walkable||!_grid.getNode(_tempNode.x,testNode.y).walkable)
							continue;
						var cost:int=_straightCost;
						if(testNode.x!=_tempNode.x&&testNode.y!=_tempNode.y)
							cost=_sqrt2;
						var g:int=cost+testNode.g;
						var h:int=manhattan(testNode);
//						var h:int=diagonal(testNode);
						var f:int=g+h;
						if(_openList.indexOf(testNode)!=-1||_closeList.indexOf(testNode)!=-1)
						{
							if(f<testNode.f)
							{
								testNode.parentNode=_tempNode;
								testNode.g=g;
								testNode.h=h;
								testNode.f=f;
								_openList.update(testNode);
							}
						}else
						{
							testNode.parentNode=_tempNode;
							testNode.g=g;
							testNode.h=h;
							testNode.f=f;
							_openList.push(testNode);	
						}
					}
				}
				if(_openList.length==0)
				{
					trace("未找到路径");
				}
				
				var nextNode:AStarNode=_openList.shift() as AStarNode;
				_tempNode=nextNode;
				_closeList.push(nextNode);
				
			}
			//返回路径
			var node:AStarNode=_endNode;
			_path.push(node);
			while(node!=_startNode)
			{
				node=node.parentNode;
				_path.unshift(node);
			}
		}
		//曼哈顿
		private function manhattan(node:AStarNode):Number
		{
			return Math.abs(node.x-_endNode.x)*_straightCost+Math.abs(node.y-_endNode.y)*_straightCost;
		}
		//对角线估价法
		private function diagonal(node:AStarNode):Number
		{
			var dx:Number=Math.abs(node.x - _endNode.x);
			var dy:Number=Math.abs(node.y - _endNode.y);
			var diag:Number=Math.min(dx, dy);
			var straight:Number=dx + dy;
			return _sqrt2 * diag + _straightCost * (straight - 2 * diag);
		}
	}
}