﻿package  {	import flash.display.Sprite;		public class StraddlingCheckerboard	{		public static const NUMERALS:Array = new Array ('0','1','2','3','4','5','6','7','8','9');		public static const HIGH_FREQUENCY:Array = new Array (' ',' ','E','S','T','O','N','I','A','R');		public static const LOW_FREQUENCY:Array = new Array ('B','C','D','F','G','H','J','K','L','M','P','Q','U','V','W','X','Y','Z','/','.');				private var rows:Array;				private var row1:Array;		private var row2:Array;		private var row3:Array;		private var row4:Array;				private var row3Key:int;		private var row4Key:int;				private var escapeKeys:Array;				private var encodeTable:Object;				/* Example Board				 	0	1	2	3	4	5	6	7	8	9		 	E	T	 	A	O	N	 	R	I	S		2	B	C	D	F	G	H	J	K	L	M		6	P	Q	/	U	V	W	X	Y	Z	.		*/		public function StraddlingCheckerboard ():void		{			// Create Row 1			row1 = mixArray (NUMERALS);						// Create Row 2			row2 = mixArray ( HIGH_FREQUENCY );			var blankIndex1:int = row2.indexOf( ' ', 0 );			var blankIndex2:int = row2.indexOf( ' ', blankIndex1 + 1 );						row3Key = row1[blankIndex1];			row4Key = row1[blankIndex2];			// Creat Rows 3 & 4			var remaining:Array = mixArray ( LOW_FREQUENCY );			row3 = remaining.splice( 0, 10 )			row4 = remaining.splice( 0 );			// Pad the info on the left			row1.unshift( ' ' );			row2.unshift( ' ' );			row3.unshift( row3Key );			row4.unshift( row4Key );			// Find location of escape keys			escapeKeys = new Array();			var numberIndex:int;			if ( row3.indexOf('.') != -1 )			{				numberIndex = row3.indexOf('.');				escapeKeys[0] = row3Key + row1[numberIndex];			}			else			{				numberIndex = row4.indexOf('.');				escapeKeys[0] = row4Key + row1[numberIndex];			}						if ( row3.indexOf('/') != -1  )			{				numberIndex = row3.indexOf('/');				escapeKeys[1] = row3Key + row1[numberIndex];			}			else			{				numberIndex = row4.indexOf('/');				escapeKeys[1] = row4Key + row1[numberIndex];			}						rows = new Array();			rows.push ( row1, row2, row3, row4 ); // quick lookup by 2D Array						encodeTable = new Object();						var index:int;			var num:String;			var prefix:String;			var i:int;						for (i = 0; i < NUMERALS.length; ++i )			{				num = NUMERALS[i];				prefix = escapeKeys[ Math.floor( Math.random() * 2 ) ];				var suffix:String = String ( row1.indexOf (num) - 1 );								encodeTable[num] =  prefix + suffix;			}						for ( i = 0; i < HIGH_FREQUENCY.length; ++i )			{				var str:String = HIGH_FREQUENCY[i];				if ( str != ' ')				{					index = row2.indexOf( str );					num = row1[index];										encodeTable[ str ] = num;				}			}						for ( i = 0; i < LOW_FREQUENCY.length; ++i )			{				str = LOW_FREQUENCY[i];				if ( str != '.' && str != '/')				{					if (row3.indexOf( str ) != -1)					{						index = row3.indexOf( str );						num = row3Key + row1[index];					}					else					{						index = row4.indexOf( str );						num = row4Key + row1[index];					}					encodeTable[ str ] = num;				}			}		}				private function mixArray ( array:Array ):Array 		{			var length = array.length;			var mixed:Array = array.slice();			var rn:int;			var el:Object;						for (var i:int = 0; i < length; ++i) 			{				el = mixed[i];				mixed[i] = mixed[rn = Math.floor( Math.random() * length )];				mixed[rn] = el;			}			return mixed;		}				public function encode (unencodedMessage:String):String		{			var messageArray:Array = unencodedMessage.split('');			var returnString:String = '';			for (var i:int = 0; i < messageArray.length; ++i)			{				var char:String = messageArray[i] as String;				char = char.toUpperCase();				if (encodeTable[char] != null)					returnString += encodeTable[char];			}			return returnString;		}				private function decodeNumbers(idx:String):String		{			for (var i:String in encodeTable)			{				if (encodeTable[i] == idx) return(i)			}			return '';		}				public function decode (encodedMessage:String):String		{			// decode an encoded message with the current checkerboard			var retString:String=''			var pos:int = 0;						while(pos < encodedMessage.length)			{				var numberIdx:String =encodedMessage.charAt(pos) + encodedMessage.charAt(pos + 1) + encodedMessage.charAt(pos + 2);				if ( encodedMessage.charAt(pos) != row4[0].toString() && encodedMessage.charAt(pos) != row3[0].toString() )				{					retString += row2[row1.indexOf(encodedMessage.charAt(pos))];					pos ++				}				else if (row3[0] == encodedMessage.charAt(pos) &&( row3[row1.indexOf(encodedMessage.charAt(pos + 1))] == '.'|| row3[row1.indexOf(encodedMessage.charAt(pos + 1))] == '/'))				{					retString += decodeNumbers(numberIdx);					pos += 3;				}				else if (row4[0] == encodedMessage.charAt(pos) &&( row4[row1.indexOf(encodedMessage.charAt(pos + 1))] == '.'|| row4[row1.indexOf(encodedMessage.charAt(pos + 1))] == '/'))				{					retString += decodeNumbers(numberIdx);					pos += 3;				}				else 				{					if (row3[0] == encodedMessage.charAt(pos))					{						retString += row3[row1.indexOf(encodedMessage.charAt(pos + 1))];						pos += 2;					}					else if (row4[0] == encodedMessage.charAt(pos))					{						retString += row4[row1.indexOf(encodedMessage.charAt(pos + 1))];						pos += 2;					}				}			}			return retString;		}				public function traceLookup ():void		{			for ( var s in encodeTable )			{				trace ('"'+ s + '" = ' + encodeTable[s]);			}		}				public function drawTable():String		{			return toString();		}				public function toString():String		{			var output:String = ''; 			if (row1) output += row1.join(' ') + '\n';			if (row2) output += row2.join(' ') + '\n';			if (row3) output += row3.join(' ') + '\n';			if (row4) output += row4.join(' ');			return output;		}	}}