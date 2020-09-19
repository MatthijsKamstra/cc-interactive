package interactive;

import Settings.SketchType;

class Squares extends SketcherBase {
	// size
	var stageW = 1080; // 1024; // video?
	var stageH = 1080; // 1024; // video?

	// start position
	var startX:Float = 0.0;
	var startY:Float = 0.0;
	var speed:Float = 2.0;

	// colors
	var _color0:RGB = null;
	var _color1:RGB = null;
	var _color2:RGB = null;
	var _color3:RGB = null;
	var _color4:RGB = null;
	var _colorArray:Array<RGB> = [];

	public function new() {
		var settings:Settings = new Settings(stageW, stageH, SketchType.CANVAS);
		settings.autostart = true;
		settings.padding = 0;
		settings.scale = true;
		settings.elementID = 'canvas-${toString()}';
		super(settings);
		// stop(); // animation
	}

	// ____________________________________ setup ____________________________________

	override function setup() {
		description = '${toString()}';
		trace('SETUP :: ${toString()} -> override public function setup()');

		// start position
		startX = w2;
		startY = h2;

		// start
		setColors();
		initGamepad();
	}

	// ____________________________________ canvas animation stuff ____________________________________

	function drawShape() {
		// reset previous sketch
		sketch.clear();

		// background color
		sketch.makeBackground(getColourObj(_color0));

		// var circle = sketch.makeCircle(startX, startY, 100);
		// circle.setFill(getColourObj(_color4));

		var total = 10;
		var centerX = w2;
		var centerY = h2;
		var startW = 1000;
		var startH = 1000;
		var endW = 100;
		var endH = 100;

		var scale = startW / 10;

		// var stageW = 1080; // 1024; // video?
		// var stageH = 1080; // 1024; // video?

		for (i in 0...total) {
			var square = sketch.makeRectangle(centerX, centerY, startW - (100 * i), startH - (100 * i));
			square.setFill(getColourObj(_color0), 0.4);
			square.setStroke(getColourObj(_color4));
		}
		// var square = sketch.makeRectangle(centerX, centerY, startW, startH);
		// square.setFill(getColourObj(_color0), 0.4);
		// square.setStroke(getColourObj(_color4));

		// var square = sketch.makeRectangle(startX, startY, 100, 100, true);
		// square.setFill(getColourObj(_color0));
		// square.setStroke(getColourObj(_color3));

		// use grid to generate totale amount of shapes/etc
		// for (i in 0...grid.array.length) {
		// 	var p:Point = grid.array[i];
		// 	var rect = sketch.makeRectangle(p.x, p.y, cellsize, cellsize);
		// 	rect.setFill(getColourObj(_colorArray[MathUtil.randomInt(_colorArray.length - 1)]));
		// }

		// update sketch, to draw svg or canvas
		sketch.update();
	}

	// ____________________________________ override ____________________________________

	/**
	 * the magic happens here, every class should have a `draw` function
	 */
	override function draw() {
		// trace('DRAW :: ${toString()} -> override public function draw()');
		drawShape();
	}

	// ____________________________________ color ____________________________________

	function setColors() {
		var colorArray = ColorUtil.niceColor100SortedString[randomInt(ColorUtil.niceColor100SortedString.length - 1)];
		_color0 = hex2RGB(colorArray[0]);
		_color1 = hex2RGB(colorArray[1]);
		_color2 = hex2RGB(colorArray[2]);
		_color3 = hex2RGB(colorArray[3]);
		_color4 = hex2RGB(colorArray[4]);
		_colorArray = [_color0, _color1, _color2, _color3, _color4];
	}

	// ____________________________________ gamepad ____________________________________

	function initGamepad() {
		var gamePad = new SNES();
		gamePad.setup();
		gamePad.onSelectOnce(onSelectHandler); // specific type, just press once
		gamePad.onStartOnce(onStartHandler); // specific type, just press once
		gamePad.onLeftBottomOnce(onLeftBottomHandler); // specific type, just press once
		gamePad.onRightBottomOnce(onRightBottomHandler); // specific type, just press once
		gamePad.onButton(onButton); // all other button, just fire as much as possible
		gamePad.onButtonOnce(CCGamepad.BUTTON_B, onButtonOnce); // all other button, just fire as much as possible
		gamePad.onAxis(onAxis); // all other button, just fire as much as possible
	}

	function onSelectHandler(e) {
		console.log('onSelectHandler: ', e);
	}

	function onStartHandler(e) {
		console.log('onStartHandler: ', e);
	}

	function onButtonOnce(e) {
		console.log('>> onButtonOnce: ', e);
	}

	function onLeftBottomHandler(e) {
		console.log('onLeftBottomHandler: ', e);
	}

	function onRightBottomHandler(e) {
		console.log('onRightBottomHandler: ', e);
	}

	function onAxis(e:CCGamepad.JoystickObj) {
		// console.log('onAxis: ', joystickObj);

		startX += (e.x * speed);
		startY += (e.y * speed);

		// switch (e.desc) {
		// 	case CCGamepad.AXIS_LEFT_DISC:
		// 		console.log('--> ${e.desc}');
		// 	case CCGamepad.AXIS_RIGHT_DISC:
		// 		console.log('--> ${e.desc}');
		// 	case CCGamepad.AXIS_UP_DISC:
		// 		console.log('--> ${e.desc}');
		// 	case CCGamepad.AXIS_DOWN_DISC:
		// 		console.log('--> ${e.desc}');
		// 	case CCGamepad.AXIS_DOWN_RIGHT_DISC:
		// 		console.log('--> ${e.desc}');
		// 	case CCGamepad.AXIS_DOWN_LEFT_DISC:
		// 		console.log('--> ${e.desc}');
		// 	case CCGamepad.AXIS_UP_RIGHT_DISC:
		// 		console.log('--> ${e.desc}');
		// 	case CCGamepad.AXIS_UP_LEFT_DISC:
		// 		console.log('--> ${e.desc}');
		// 	case CCGamepad.AXIS_CENTER_DISC:
		// 		console.log('--> ${e.desc}');

		// 	default:
		// 		trace("case '" + e + "': trace ('" + e + "');");
		// }
	}

	function onButton(disc:String) {
		// console.log('onUpdateHandler: ', e);
		switch (disc) {
			case CCGamepad.BUTTON_A_DISC:
				console.log('--> $disc');
			case CCGamepad.BUTTON_B_DISC:
				console.log('--> $disc');
			case CCGamepad.BUTTON_X_DISC:
				console.log('--> $disc');
			case CCGamepad.BUTTON_Y_DISC:
				console.log('--> $disc');
			default:
				trace("case '" + disc + "': trace ('" + disc + "');");
		}
	}
}
