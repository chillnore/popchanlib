package com.popchan.algorithm.findpath
{
	/**
	 *寻路节点
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class AStarNode
	{
		public var x:int;
		public var y:int;
		public var walkable:Boolean=true;
		public var parentNode:AStarNode;
		public var f:Number=0;
		public var g:Number=0;
		public var h:Number=0;
	}
}