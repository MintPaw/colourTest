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
	private var _anim:FlxSprite = new FlxSprite();
	private var _oldData:BitmapData;
	private var _frameCount:Int = 0;
	private var _matrix:Array<Float>;

	public function new()
	{
		super();
	}

	override public function create():Void
	{
		// Setting up animation, don't worry about this
		_anim.loadGraphicFromTexture(
				new TexturePackerData("assets/player.json", "assets/player.png"));
		_anim.animation.addByPrefix("default", "player_blue_SMG_right_running");
		_anim.animation.play("default");
		_anim.x = FlxG.width / 2 - _anim.width / 2;
		_anim.y = FlxG.height / 2 - _anim.height / 2;
		_anim.scale.x *= 2;
		_anim.scale.y *= 2;
		add(_anim);

		// Caching the old bitmap data, because my effects are modifying the
		// FlxSprite's pixels permanently I can't keep applying new effects because
		// they'll stack, so to apply a new effect I'll need to use this instead
		_oldData = _anim.pixels.clone();
	}

	override public function update()
	{
		_frameCount++;
		var useMatrix:Bool = false;

		if (useMatrix)
		{
			// Generate the effects depending on frame, a new effect every 100
			if (_frameCount / 100 == 1)
			{
				// Take away half the blue
				applyEffect([
						1, 0, 0, 0, 0,
						0, 1, 0, 0, 0,
						0, 0, 0.5, 0, 0,
						0, 0, 0, 1, 0
				]);
			}
			else if (_frameCount / 100 == 2)
			{
				// Normalize, e.g. Greyscale
				applyEffect([
						0.5, 0.5, 0.5, 0, 0,
						0.5, 0.5, 0.5, 0, 0,
						0.5, 0.5, 0.5, 0, 0,
						0.5, 0.5, 0.5, 1, 0
				]);
			}
			else if (_frameCount / 100 == 3)
			{
				// Invert
				applyEffect([
						-1, 0, 0, 0, 255,
						0, -1, 0, 0, 255,
						0, 0, -1, 0, 255,
						0, 0, 0, 1, 0
				]);
			}
			else if (_frameCount / 100 == 4)
			{
				// Reset to identity
				applyEffect([
						1, 0, 0, 0, 0,
						0, 1, 0, 0, 0,
						0, 0, 1, 0, 0,
						0, 0, 0, 1, 0
				]);
			}
		}
		else
		{
			// Swap the blue and red channel
			if (_frameCount / 100 == 1)
			{
				// Make my red green and blue arrays
				var reds:Array<Int> = [];
				var greens:Array<Int> = [];
				var blues:Array<Int> = [];
				
				// Start assigning colours
				for (i in 0...255)
				{
					// Notice that I've assigned all the reds to actually be blues
					reds.push(FlxColorUtil.getColor24(0, 0, i));
					// Greens are unchanged
					greens.push(FlxColorUtil.getColor24(0, i, 0));
					// All these blues are actually reds
					blues.push(FlxColorUtil.getColor24(i, 0, 0));
				}

				_anim.pixels.paletteMap(
						_anim.pixels,
						_anim.pixels.rect,
						new Point(0, 0),
						reds,
						greens,
						blues,
						// This would be alpha if you wanted to change the alpha channel for
						// whatever reason
						null);
			}
		}

		super.update();
	}

	private function applyEffect(m:Array<Float>):Void
	{
		// Apply a filter to the source pixels
		_anim.pixels.applyFilter(
				// You have to use the old data here, otherwise effects will stack
				_oldData,
				// Old rect as well, some filter like blur cause resizing
				_oldData.rect,
				// Start obviously at 0,0
				new Point(0, 0),
				// Generateion of the filter
				new ColorMatrixFilter(m));
	}
}
