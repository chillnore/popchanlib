package com.popchan.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 *swf文件读取
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class SwfFileRead
	{
		
		/**
		 *获取swf中的所有类定义 
		 * @param by
		 * @return 
		 * 
		 */
		public static function getAllClassName(by:ByteArray):Array
		{
			var list:Array=[];
			by.endian=Endian.LITTLE_ENDIAN;
			by.writeBytes(by,8);
			by.uncompress();
			by.position=Math.ceil(((by[0]>>>3)*4+5)/8)+4;
			while(by.bytesAvailable>2)
			{
				var head:int=by.readUnsignedShort();
				var size:int=head&63;
				if(size==63)size=by.readInt();
				if(head>>6!=76)
					by.position+=size;
				else
				{
					head=by.readShort();
					for(var i:int=0;i<head;i++)
					{
						by.readShort();
						size=by.position;
						while(by.readByte()!=0)
						{};
						size=by.position-(by.position=size);
						list.push(by.readUTFBytes(size));
					}
				}
			}
			return list;
		}
		
	}
}