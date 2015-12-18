package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.loaders.TexturePackerData;
import flixel.util.FlxColorUtil;
import openfl.geom.ColorTransform;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.filters.ColorMatrixFilter;

class MainState extends FlxState
{
	private var _anim:FlxColourSprite = new FlxColourSprite();

	public function new()
	{
		super();
	}

	override public function create():Void
	{
		_anim.loadGraphicFromTexture(
				new TexturePackerData("assets/player.json", "assets/player.png"));
		_anim.animation.addByPrefix("default", "player_blue_SMG_right_running");
		_anim.animation.play("default");
		_anim.x = FlxG.width / 2 - _anim.width / 2;
		_anim.y = FlxG.height / 2 - _anim.height / 2;
		_anim.scale.x *= 2;
		_anim.scale.y *= 2;
		add(_anim);
	}

	override public function update()
	{
		super.update();
	}

}
