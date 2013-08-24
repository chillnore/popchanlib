package com.popchan.algorithm.findpath
{
	/**
	 *寻路网格
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class AstarGrid
	{
		protected var _nodes:Array;
		protected var _startNode:AStarNode;
		protected var _endNode:AStarNode;
		protected var _rowNum:int;
		protected var _colNum:int;
		/**
		 * 
		 * @param nodes 二维数组
		 * 
		 */
		public function AstarGrid(nodes:Array=null)
		{
			if(nodes!=null)
				this.nodes=nodes;
		}
		/**
		 *设置起点 
		 * @param x
		 * @param y
		 * 
		 */
		public function setStartNode(x:int,y:int):void
		{
			_startNode=_nodes[x][y];
		}
		public function get startNode():AStarNode
		{
			return _startNode;
		}
		/**
		 *设置起点 
		 * @param x
		 * @param y
		 * 
		 */
		public function setEndNode(x:int,y:int):void
		{
			_endNode=_nodes[x][y];	
		}
		public function get endNode():AStarNode
		{
			return _endNode;
		}
		/**
		 *获取任意节点 
		 * @param x
		 * @param y
		 * @return 
		 * 
		 */
		public function getNode(x:int,y:int):AStarNode
		{
			return _nodes[x][y];
		}
		/**
		 * 网格所有节点
		 * @return 
		 * 
		 */
		public function get nodes():Array
		{
			return _nodes;
		}
		
		/**
		 * @private
		 */
		public function set nodes(value:Array):void
		{
			if(value!=null)
			{
				_nodes = value;
				_rowNum=value.length;
				_colNum=value[0].length;
			}
		}
		/**
		 *设置节点是否可以通过 
		 * @param x
		 * @param y
		 * @param value
		 * 
		 */
		public function setNodeWalkable(x:int,y:int,value:Boolean):void
		{
			_nodes[x][y].walkable=value;
		}
		/**
		 *行数 
		 * @return 
		 * 
		 */
		public function get rowNum():int
		{
			return _rowNum;
		}
		/**
		 *列数 
		 * @return 
		 * 
		 */
		public function get colNum():int
		{
			return _colNum;
		}
	}
}