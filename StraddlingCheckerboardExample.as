﻿package{	import StraddlingCheckerboard;	import flash.display.Sprite;	import flash.events.Event;		public class StraddlingCheckerboardExample extends Sprite	{		var checkerboard:StraddlingCheckerboard;				public function StraddlingCheckerboardExample ()		{			checkerboard = new StraddlingCheckerboard();			key.text = checkerboard.drawTable();			code.text = checkerboard.encode(message.text);						message.addEventListener (Event.CHANGE, onChange);						message.restrict = 'A-z0-9 ';		}				private function onChange (e:Event):void		{			code.text = checkerboard.encode(message.text);		}	}}