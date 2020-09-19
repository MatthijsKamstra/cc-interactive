package;

import js.Browser.*;
import js.html.*;

// import model.constants.App;
using StringTools;

class Main {
	public function new() {
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('${App.NAME} Dom ready :: build: ${App.getBuildDate()}');
			setupCC();
		});
	}

	function setupCC() {
		var cc = new interactive.Squares();
	}

	static public function main() {
		var app = new Main();
	}
}
