package com.popchan.algorithm.pathfinding
{
	/**
	 *寻路的格子世界 (起点，终点，格子列表)
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class TileWorld
	{
		protected var _tiles:Array;
		protected var _startTile:TileVO;
		protected var _endTile:TileVO;
		protected var _rowNum:int;
		protected var _colNum:int;
		protected var _tileWidth:int;
		protected var _tileHeight:int;
		/**
		 * 
		 * @param nodes 二维数组
		 * 
		 */
		public function TileWorld(tiles:Array=null)
		{
			if(tiles!=null)
				this.tiles=tiles;
		}
		/**
		 *设置起点 
		 * @param row
		 * @param col
		 * 
		 */
		public function setStartTile(row:int,col:int):void
		{
			_startTile=_tiles[row][col];
		}
		public function get startTile():TileVO
		{
			return _startTile;
		}
		/**
		 *设置终点 
		 * @param row
		 * @param col
		 * 
		 */
		public function setEndTile(row:int,col:int):void
		{
			_endTile=_tiles[row][col];	
		}
		public function get endTile():TileVO
		{
			return _endTile;
		}
		/**
		 *获取任意Tile
		 * @param row
		 * @param col
		 * @return 
		 * 
		 */
		public function getTile(row:int,col:int):TileVO
		{
			if(row<rowNum&&col<colNum&&row>=0&&col>=0)
				return _tiles[row][col];
			return null;
		}
		/**
		 * 所有tiles
		 * @return 
		 * 
		 */
		public function get tiles():Array
		{
			return _tiles;
		}
		
		/**
		 * @private
		 */
		public function set tiles(value:Array):void
		{
			if(value!=null)
			{
				_tiles = value;
				_rowNum=value.length;
				_colNum=value[0].length;
			}
		}
		/**
		 *设置tile是否可以通过 
		 * @param row
		 * @param col
		 * @param value
		 * 
		 */
		public function setTileWalkable(row:int,col:int,value:Boolean):void
		{
			_tiles[row][col].walkable=value;
		}
		/**
		 *是否可通过 
		 * @param row
		 * @param col
		 * @return 
		 * 
		 */
		public function getTileWalkable(row:int,col:int):Boolean
		{
			if(row<rowNum&&col<colNum&&row>=0&&col>=0)
				return _tiles[row][col].walkable;
			return false;
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
		/**
		 *当一个点不可行走时候，寻找其周围最近的可行走的点 
		 * @param start
		 * @param end
		 * @return 
		 * 
		 */
		public function getNearbyTile(start:TileVO,end:TileVO):TileVO
		{
			var depth:int=searchAroundTilesDepth(end);
			if(depth==0)
				return end;
			var minRow:int=(end.row-depth<0)?0:(end.row-depth);
			var maxRow:int=(end.row+depth>_rowNum-1)?(_rowNum-1):(end.row+depth);
			var minCol:int=(end.col-depth<0)?0:(end.col-depth);
			var maxCol:int=(end.col+depth>_colNum-1)?(_colNum-1):(end.col+depth);
			var maxDis:Number=100000;
			var tempTile:TileVO;
			for(var i:int=minRow;i<=maxRow;i++)
			{
				for(var j:int=minCol;j<=maxCol;j++)
				{
					var tile:TileVO=_tiles[i][j];
					if(!tile.walkable)continue;
					var dx:Number=start.row-tile.row;
					var dy:Number=start.col-tile.col;
					var dis:Number=Math.sqrt(dx*dx+dy*dy);
					if(dis<maxDis)
					{
						tempTile=tile;
						maxDis=dis;
					}
				}
			}
			return tempTile;
		}
		/**
		 *获取周围可以通行的点离该点的层数 
		 * @param tile
		 * @return 
		 * 
		 */
		protected function searchAroundTilesDepth(tile:TileVO):int
		{
			var searchCount:int=10;
			var count:int=1;
			while(count<searchCount)
			{
				var minRow:int=(tile.row-count<0)?0:(tile.row-count);
				var maxRow:int=(tile.row+count>_rowNum-1)?(_rowNum-1):(tile.row+count);
				var minCol:int=(tile.col-count<0)?0:(tile.col-count);
				var maxCol:int=(tile.col+count>_colNum-1)?(_colNum-1):(tile.col+count);
				for(var i:int=minRow;i<=maxRow;i++)
				{
					for(var j:int=minCol;j<=maxCol;j++)
					{
						if(_tiles[i][j].walkable)
							return count;
					}
				}
				count++;
			}
			return 0;
		}

		public function get tileWidth():int
		{
			return _tileWidth;
		}

		public function set tileWidth(value:int):void
		{
			_tileWidth = value;
		}

		public function get tileHeight():int
		{
			return _tileHeight;
		}

		public function set tileHeight(value:int):void
		{
			_tileHeight = value;
		}


	}
}