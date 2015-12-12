package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.loaders.TexturePackerData;

class MainState extends FlxState
{
	
	public function new()
	{
		super();
	}

	override public function create():Void
	{
		// Loading in graphics
		var anim:FlxSprite = new FlxSprite();
		anim.loadGraphicFromTexture(
				new TexturePackerData("assets/player.json", "assets/player.png"));

		//anim.animation.
		add(anim);
	}
}
