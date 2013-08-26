package com.popchan.algorithm.pathfinding
{
	/**
	 *寻路中的单元格
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class TileVO
	{
		/**
		 *行 
		 */
		public var row:int;
		/**
		 *列 
		 */
		public var col:int;
		/**
		 *是否可通过 
		 */
		public var walkable:Boolean=true;
		/**
		 *父节点 
		 */
		public var parentTile:TileVO;
		/**
		 *记分总代价 f=g+h
		 */
		public var f:Number=0;
		/**
		 *起始格子到当前格子的值 
		 */
		public var g:Number=0;
		/**
		 *当前格子到结束格子的值 
		 */
		public var h:Number=0;
		/**
		 *格子代表的类型 
		 */
		public var type:int;
	}
}