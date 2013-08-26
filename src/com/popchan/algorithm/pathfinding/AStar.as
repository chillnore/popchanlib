package com.popchan.algorithm.pathfinding
{
	import com.popchan.algorithm.line.LineGenerateCore;
	import com.popchan.algorithm.rpg.GamePointUtil;
	
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	/**
	 *寻路
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class AStar
	{
		/*路径*/
		protected var _path:Array;
		protected var _startTile:TileVO;
		protected var _endTile:TileVO;
		/*开放列表---存放已经考察过的tile*/
		protected var _openList:BinaryHeap;
		/*已考察列表---存放分数最小的tile*/
		protected var _closedList:Array;
		protected var _world:TileWorld;
		private static var _instance:AStar;
		/*最大搜索步骤*/
		protected var _searchLimit:int=2000;
		protected var _searchCount:int=0;
		public static function get instance():AStar
		{
			if(_instance==null)
				_instance=new AStar();
			return _instance;
		}
		public function findPath(world:TileWorld,searchLimit:int=2000):Array
		{
			
			this._world=world;
			_startTile=_world.startTile;
			_endTile=_world.endTile;
			_path=[];
			_openList=new BinaryHeap("f");
			_closedList=[];
			_searchCount=0;
			_searchLimit=searchLimit;
			
			if(!_endTile.walkable)
			{
				_endTile=_world.getNearbyTile(_startTile,_endTile);
			}
			
			var t:int=getTimer();
			
			//将开始tile放入开放列表
			var _tempTile:TileVO;
			_openList.push(_startTile);
			while(_openList.length>0)
			{
				if(_searchCount>_searchLimit)
				{
					trace("寻路超过最大步骤"+_searchLimit);
					return null
				}
				_tempTile=_openList.shift() as TileVO;
				if(_tempTile==_endTile)//寻路结束
				{
					break;
				}else
				{
					//将其放入关闭列表
					_closedList.push(_tempTile);
					var list:Array=getRoundTiles(_tempTile);
					for each(var tile:TileVO in list)
					{
						//计分 对角线用1.414计算，水平的用1计算
						var cost:int=1;
						if(tile.row!=_tempTile.row&&tile.col!=_tempTile.col)
							cost=1.414;
						var g:Number=tile.g+cost;
						var h:Number=manhattan(tile);
						var f:Number=g+h;
						if(_openList.indexOf(tile)!=-1)
						{
							if(tile.f>f)
							{
								tile.parentTile=_tempTile;
								tile.f=f;
								tile.g=g;
								tile.h=h;
								_openList.update(tile);
							}
						}else
						{
							tile.parentTile=_tempTile;
							tile.g=g;
							tile.h=h;
							tile.f=f;
							_openList.push(tile);
						}
					}
				}
				if(_openList.length==0)
				{
					trace("路径没有找到");
					return _path;
				}
				_searchCount++;
				
			}
			//返回路径
			var mytile:TileVO=_endTile;
			_path.push(mytile);
			while(mytile!=_startTile)
			{
				mytile=mytile.parentTile;
				_path.unshift(mytile);
			}
			trace("寻路耗时:"+(getTimer()-t)+"ms");
			
			smoothPath();
			return _path;
		}
		/**
		 *路径平滑算法 消除共线的点，消除拐点 
		 * 
		 */
		protected function smoothPath():void
		{
			if(_path==null)return;
			var len:int=_path.length;
			if(len>2)
			{
				//A,B,C  ab,ac斜率K相等即可
				var k:Number=(_path[len-1].row-_path[len-2].row)/(_path[len-1].col-_path[len-2].col);
				var tempK:Number=0;
				for(var i:int=len-3;i>=0;i--)
				{
					tempK=(_path[i+1].row-_path[i].row)/(_path[i+1].col-_path[i].col);
					if(tempK==k)
					{
						_path.splice(i+1,1);
					}else
					{
						k=tempK;
					}
				}
				//消除拐点
				len=_path.length;
				for(i=len-1;i>=0;i--)
				{
					for(var j:int=0;j<=i-2;j++)
					{
						if(!getLineHasObstacle(_path[i],_path[j]))//若无障碍，则剔除中间所有的点
						{
							for(var m:int=i-1;m>j;m--)
							{
								_path.splice(m,1);
							}
							i=j;
							len=_path.length;
							break;
						}
					}
				}
			
			}
		}
		public function getLineHasObstacle(start:TileVO,end:TileVO):Boolean
		{
			var arr:Array=LineGenerateCore.getBresenhamLinePoints(start.row,start.col,end.row,end.col);
			for each(var p:Point in arr)
			{
				if(!_world.getTile(p.x,p.y).walkable)
					return true;
			}
			return false;
		}
		
		/**
		 *获取四周的tile 排除不可走或者已在关闭列表里面的 
		 * 放在出现代价相同的情况下 所以优先选4个正方向的，然后再选斜方向的
		 * @param tile
		 * @return 
		 * 
		 */
		public function getRoundTiles(tile:TileVO):Array
		{
			var list:Array=[];
			var tempTile:TileVO;
			var rightWalkable:Boolean=false;
			var leftWalkable:Boolean=false;
			var upWalkable:Boolean=false;
			var downWalkable:Boolean=false;
			//右
			tempTile=_world.getTile(tile.row,tile.col+1);
			if(tempTile&&tempTile.walkable)
			{
				rightWalkable=true;
				if(_closedList.indexOf(tempTile)==-1)
					list.push(tempTile);
			}
			//左
			tempTile=_world.getTile(tile.row,tile.col-1);
			if(tempTile&&tempTile.walkable)
			{
				leftWalkable=true;
				if(_closedList.indexOf(tempTile)==-1)
					list.push(tempTile);
			}
			//上
			tempTile=_world.getTile(tile.row-1,tile.col);
			if(tempTile&&tempTile.walkable)
			{
				upWalkable=true;
				if(_closedList.indexOf(tempTile)==-1)
					list.push(tempTile);
			}
			//下
			tempTile=_world.getTile(tile.row+1,tile.col);
			if(tempTile&&tempTile.walkable)
			{
				downWalkable=true;
				if(_closedList.indexOf(tempTile)==-1)
					list.push(tempTile);
			}
			//4个角落的时候，要防止出现穿对角线
			//右下
			tempTile=_world.getTile(tile.row+1,tile.col+1);
			if(rightWalkable&&downWalkable&&tempTile&&tempTile.walkable&&_closedList.indexOf(tempTile)==-1)
			{
				list.push(tempTile);
			}
			//左下
			tempTile=_world.getTile(tile.row+1,tile.col-1);
			if(leftWalkable&&downWalkable&&tempTile&&tempTile.walkable&&_closedList.indexOf(tempTile)==-1)
			{
				list.push(tempTile);
			}
			//左上
			tempTile=_world.getTile(tile.row-1,tile.col-1);
			if(leftWalkable&&upWalkable&&tempTile&&tempTile.walkable&&_closedList.indexOf(tempTile)==-1)
			{
				list.push(tempTile);
			}
			//右上
			tempTile=_world.getTile(tile.row-1,tile.col+1);
			if(rightWalkable&&upWalkable&&tempTile&&tempTile.walkable&&_closedList.indexOf(tempTile)==-1)
			{
				list.push(tempTile);
			}
			return list;
		}
		//曼哈顿
		private function manhattan(tile:TileVO):Number
		{
			return Math.abs(tile.row-_endTile.row)+Math.abs(tile.col-_endTile.col);
		}
		/**
		 *寻路最大步数 
		 * @return 
		 * 
		 */
		public function get searchLimt():int
		{
			return _searchLimit;
		}
		
		public function set searchLimt(value:int):void
		{
			_searchLimit = value;
		}
		
		
	}
}