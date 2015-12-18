package;

import flixel.FlxSprite;

class FlxColourSprite extends FlxSprite
{

	public function new()
	{
		super();
	}

	public function adjustColor(b:Float = 1, c:Float = 1, s:Float = 0):Void
	{
		var m:Array<Float> = [
			c*(1-s)*0.3086+s,(1-s)*0.3086,(1-s)*0.3086, 0, b*255-((255 - c*255) / 2), 
			(1-s)*0.6094,c*(1-s)*0.6094+s,(1-s)*0.6094, 0, b*255-((255 - c*255) / 2), 
			(1-s)*0.0820, (1-s)*0.0820, c*(1-s)*0.0820, 0, b*255-((255 - c*255) / 2), 
			0, 0, 0, 1, 0];
	}
}
