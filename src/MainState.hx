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

class MainState extends FlxState
{
	private var _anim:FlxColourSprite = new FlxColourSprite();
	private var _frameCount:Int = 0;

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

		_anim.cachePixels();

	}

	override public function update()
	{
		_frameCount++;

		// Default
		if (_frameCount == 100) _anim.adjustColor(0, 1, 1, 0, true)
		// Brightness
		else if (_frameCount == 200) _anim.adjustColor(0.5, 1, 1, 0, true)
		// Contrast
		else if (_frameCount == 300) _anim.adjustColor(0, 1.5, 1, 0, true)
		// Saturation
		else if (_frameCount == 400) _anim.adjustColor(0, 1, 1.5, 0, true)
		// Lum
		else if (_frameCount == 500) _anim.adjustColor(0, 1.5, 1, 0, true)
		// Hue
		else if (_frameCount == 600) _anim.adjustColor(0, 1, 1, 128, true)
		// All at once
		else if (_frameCount == 700) _anim.adjustColor(0.5, 1.5, 1.5, 128, true)
		// Reset
		else if (_frameCount == 800) _frameCount = 0;
		super.update();
	}

}
