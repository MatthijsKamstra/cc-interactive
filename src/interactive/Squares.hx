package interactive;

import haxe.Timer;
import Settings.SketchType;
import sketcher.export.VideoExport;

class Squares extends SketcherBase {
	// size
	var stageW = 1080; // 1024; // video?
	var stageH = 1080; // 1024; // video?

	/// sizes squares
	var totalShapes = 50;
	var startW = 800;
	var startH = 800;
	var endW = 100;
	var endH = 100;

	// speed
	final DEFAULT_SPEED:Float = 1.0;
	final DEFAULT_MAX_SPEED:Float = 10.0;
	var currentSpeed:Float = 3.0;
	var rotationSpeed:Float = 0.0;

	// start position
	var mouseX:Float = 0.0;
	var mouseY:Float = 0.0;

	// colors
	var _color0:RGB = null;
	var _color1:RGB = null;
	var _color2:RGB = null;
	var _color3:RGB = null;
	var _color4:RGB = null;
	var _colorArray:Array<RGB> = [];

	// dat
	var message = 'dat.gui';
	var feedback = '';
	var buildversion = App.getBuildDate();
	var randomizeColor = function() {}
	var selectedShape:String;
	var startRecord = function() {};
	var stopRecord = function() {};

	// shapes
	var shapeArray = ['square', 'pentagon', 'rectangle', 'hexagon', 'circle', 'triangle', 'ellipse'];
	var shapeCounter = 0;

	// video export
	var videoExport:VideoExport;
	var isRecording:Bool = false;

	public function new() {
		message = toString();

		var settings:Settings = new Settings(stageW, stageH, SketchType.CANVAS);
		settings.autostart = true;
		settings.padding = 0;
		settings.scale = true;
		settings.elementID = 'canvas-${toString()}';
		super(settings);
		// animation
		// stop();

		init();
	}

	function init() {
		// embed dat.GUI and init
		EmbedUtil.datgui(initDatGui2);
		// video record
		videoExport = new VideoExport();
		videoExport.setCanvas(sketch.canvas);
		// videoExport.setAudio(audioEl);
		// videoExport.setDownload(downloadButton);
		videoExport.setup(); // activate everything
	}

	// ____________________________________ setup ____________________________________

	override function setup() {
		// trace('SETUP :: ${toString()} -> override public function setup()');
		description = '${toString()}';

		// start position
		mouseX = w2;
		mouseY = h2;

		// start
		setColors();
		initGamepad();
	}

	function initDatGui2() {
		var gui = new js.dat.gui.GUI();
		gui.add(this, 'message');
		gui.add(this, 'buildversion');
		gui.add(this, 'currentSpeed', DEFAULT_SPEED, DEFAULT_MAX_SPEED).listen();
		gui.add(this, 'rotationSpeed', 0.0, 10.0).listen();

		randomizeColor = function() {
			setColors();
		}
		gui.add(this, 'randomizeColor');
		// Choose from accepted values
		gui.add(this, 'selectedShape', shapeArray).listen();

		gui.add(this, 'feedback').listen();
		var toggle = gui.add(this, 'startRecord');
		toggle.onFinishChange((e) -> {
			// setup();
			// play();
			startRecording();
			feedback = 'start-recording';
		});
		var toggle = gui.add(this, 'stopRecord');
		toggle.onFinishChange((e) -> {
			videoExport.stop();
			feedback = 'stop-recording';
		});

		// gui.add(this, 'speed', -5, 5);
		// gui.add(this, 'displayOutline');
		// gui.add(this, 'explode');
	}

	function startRecording() {
		videoExport.start();
		Timer.delay(function() {
			videoExport.stop();
		}, 60 * 1000);
	}

	// ____________________________________ canvas animation stuff ____________________________________

	function drawShape() {
		// reset previous sketch
		sketch.clear();

		// background color
		sketch.makeBackground(getColourObj(_color0));

		var offsetX = (startW - endW) / totalShapes;
		var offsetY = (startH - endH) / totalShapes;
		var centerOffsetX = (w2 - mouseX) / totalShapes;
		var centerOffsetY = (h2 - mouseY) / totalShapes;

		for (i in 0...totalShapes) {
			selectedShape = shapeArray[shapeCounter];
			var centerX = w2 - (centerOffsetX * i);
			var centerY = h2 - (centerOffsetY * i);
			switch (selectedShape) {
				case 'square':
					var shape = sketch.makeRectangle(centerX, centerY, (startW - (offsetX * i)), (startH - (offsetY * i)));
					shape.setFill(getColourObj(_color0), 1);
					shape.setStroke(getColourObj(_color4));
					shape.setRotate(i * rotationSpeed);
				case 'rectangle':
					var shape = sketch.makeRectangle(centerX, centerY, (startW - (offsetX * i)), (startH - (offsetY * i) * .5));
					shape.setFill(getColourObj(_color0), 1);
					shape.setStroke(getColourObj(_color4));
					shape.setRotate(i * rotationSpeed);
				case 'circle':
					var shape = sketch.makeCircle(centerX, centerY, (startW - (offsetX * i)) * .5);
					shape.setFill(getColourObj(_color0), 1);
					shape.setStroke(getColourObj(_color4));
					shape.setRotate(i * rotationSpeed);
				case 'ellipse':
					var shape = sketch.makeEllipse(centerX, centerY, (startW - (offsetX * i)) * .5, (startH - (offsetY * i)) * .25);
					shape.setFill(getColourObj(_color0), 1);
					shape.setStroke(getColourObj(_color4));
					shape.setRotate(i * rotationSpeed);
				case 'triangle':
					var _polygon = sketch.makePolygon([]);
					_polygon.sides(centerX, centerY, 3, (startW - (offsetX * i)) * .5);
					// _polygon.rotate = sh.degree;
					_polygon.setFill(getColourObj(_color0), 1);
					_polygon.setStroke(getColourObj(_color4));
					_polygon.setRotate(i * rotationSpeed, centerX, centerY);
				case 'pentagon':
					var _polygon = sketch.makePolygon([]);
					_polygon.sides(centerX, centerY, 5, (startW - (offsetX * i)) * .5);
					// _polygon.rotate = sh.degree;
					_polygon.setFill(getColourObj(_color0), 1);
					_polygon.setStroke(getColourObj(_color4));
					_polygon.setRotate(i * rotationSpeed, centerX, centerY);
				case 'hexagon':
					var _polygon = sketch.makePolygon([]);
					_polygon.sides(centerX, centerY, 6, (startW - (offsetX * i)) * .5);
					// _polygon.rotate = sh.degree;
					_polygon.setFill(getColourObj(_color0), 1);
					_polygon.setStroke(getColourObj(_color4));
					_polygon.setRotate(i * rotationSpeed, centerX, centerY);
				default:
					trace("case '" + selectedShape + "': trace ('" + selectedShape + "');");
			}
		}

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

		gamePad.onSelectOnce(onSelectHandler);
		gamePad.onStartOnce(onStartHandler);

		gamePad.onLeftBottomOnce(onLeftBottomHandler);
		gamePad.onRightBottomOnce(onRightBottomHandler);

		gamePad.onButtonOnce(CCGamepad.BUTTON_B, onButton);
		gamePad.onButtonOnce(CCGamepad.BUTTON_A, onButton);
		gamePad.onButton(CCGamepad.BUTTON_Y, onButton);
		gamePad.onButton(CCGamepad.BUTTON_X, onButton);

		gamePad.onAxis(onAxis); // all other button, just fire as much as possible
	}

	function onSelectHandler(e) {
		console.log('onSelectHandler: ', e);
		if (isRecording) {
			console.log('[gamepad.selectBtn] (current recording) :: stop recording');
			feedback = '[select] stop recording';
			videoExport.stop();
		} else {
			console.log('[gamepad.selectBtn] (current not recording) :: start recording');
			feedback = '[select] start recording';
			startRecording();
		}
		isRecording = !isRecording;
	}

	function onStartHandler(e) {
		console.log(' onStartHandler:', e);
	}

	function onButtonOnce(e) {
		console.log(' >> onButtonOnce:', e);
	}

	function onLeftBottomHandler(e) {
		// console.log(' onLeftBottomHandler:', e);
		currentSpeed--;
		if (currentSpeed <= DEFAULT_SPEED)
			currentSpeed = DEFAULT_SPEED;

		console.log(currentSpeed);
	}

	function onRightBottomHandler(e) {
		// console.log(' onRightBottomHandler:', e);
		currentSpeed++;
		if (currentSpeed >= DEFAULT_MAX_SPEED)
			currentSpeed = DEFAULT_MAX_SPEED;
		console.log(currentSpeed);
	}

	function onAxis(e:CCGamepad.JoystickObj) {
		// console.log(' onAxis:', joystickObj);

		mouseX += (e.x * currentSpeed);
		mouseY += (e.y * currentSpeed);

		if (mouseX - (endW * 0.5) <= 0)
			mouseX = 0 + (endW * .5);
		if (mouseX + (endW * 0.5) >= stageW)
			mouseX = stageW - (endW * .5);

		if (mouseY - (endH * 0.5) <= 0)
			mouseY = 0 + (endH * .5);
		if (mouseY + (endH * 0.5) >= stageW)
			mouseY = stageW - (endH * .5);
	}

	function onButton(e:CCGamepad.Action) {
		// console.log(' onButton:', e);
		switch (e.id) {
			case CCGamepad.BUTTON_A:
				console.log('-- > ${e.id} // change color');

				randomizeColor();
			case CCGamepad.BUTTON_B:
				shapeCounter++;
				if (shapeCounter > shapeArray.length - 1)
					shapeCounter = 0;
				console.log('--> ${e.id} // change shapes (${shapeCounter}/${shapeArray.length} :: ${shapeArray[shapeCounter]})');
			case CCGamepad.BUTTON_X:
				// console.log('--> ${e.id} // rotate +1');
				rotationSpeed += 0.1;
			case CCGamepad.BUTTON_Y:
				// console.log('--> ${e.id} // rotate -1');
				rotationSpeed -= 0.1;
				if (rotationSpeed <= 0)
					rotationSpeed = 0;
			default:
				trace("case '" + e.id + "': trace ('" + e.id + "');");
		}
	}
}
