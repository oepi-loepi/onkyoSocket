import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0;

Screen {
	id: onkyoespConfigScreen
	screenTitle: "Onkyoesp app Setup"

	function saveespURL(text) {
		if (text) {
			app.espURL = text;
		}
	}


function makeHex(statnr) {
		if (statnr) {
			if (!statnr.isNumber){app.statnrHEX = "01"}
			if ((statnr === "1") || (statnr === "01")) {app.statnrHEX = "01"}
			if ((statnr === "2") || (statnr === "02")) {app.statnrHEX = "02"}
			if ((statnr === "3") || (statnr === "03")) {app.statnrHEX = "03"}
			if ((statnr === "4") || (statnr === "04")) {app.statnrHEX = "04"}
			if ((statnr === "5") || (statnr === "05")) {app.statnrHEX = "05"}
			if ((statnr === "6") || (statnr === "06")) {app.statnrHEX = "06"}
			if ((statnr === "7") || (statnr === "07")) {app.statnrHEX = "07"}
			if ((statnr === "8") || (statnr === "08")) {app.statnrHEX = "08"}
			if ((statnr === "9") || (statnr === "09")) {app.statnrHEX = "09"}
			if ((statnr === "10") || (statnr === "0A")) {app.statnrHEX = "0A"}
			if ((statnr === "11") || (statnr === "0B")) {app.statnrHEX = "0B"}
			if ((statnr === "12") || (statnr === "0C")) {app.statnrHEX = "0C"}
			if ((statnr === "13") || (statnr === "0D")) {app.statnrHEX = "0D"}
			if ((statnr === "14") || (statnr === "0E")) {app.statnrHEX = "0E"}
			if ((statnr === "15") || (statnr === "0F")) {app.statnrHEX = "0F"}
			if ((statnr === "16") || (statnr === "10")) {app.statnrHEX = "10"}
			if ((statnr === "17") || (statnr === "1A")) {app.statnrHEX = "1A"}
			if ((statnr === "18") || (statnr === "1B")) {app.statnrHEX = "1B"}
			if ((statnr === "19") || (statnr === "1C")) {app.statnrHEX = "1C"}
			if ((statnr === "20") || (statnr === "1D")) {app.statnrHEX = "1D"}
		}

	}

	function saveradioStation1nr(text) {
		if (text) {
			makeHex(text);
			app.radioStation1nr = app.statnrHEX;
		}
	}

	function saveradioStation2nr(text) {
		if (text) {
			makeHex(text);
			app.radioStation2nr = app.statnrHEX;

		}
	}

	function saveradioStation3nr(text) {
		if (text) {
			makeHex(text);
			app.radioStation3nr = app.statnrHEX;
		}
	}

	function saveradioStation4nr(text) {
		if (text) {
			makeHex(text);
			app.radioStation4nr = app.statnrHEX;

		}
	}


	function saveradioStation1(text) {
		if (text) {
			app.radioStation1 = text;
		}
	}

	function saveradioStation2(text) {
		if (text) {
			app.radioStation2 = text;
		}
	}

	function saveradioStation3(text) {
		if (text) {
			app.radioStation3 = text;
		}
	}

	function saveradioStation4(text) {
		if (text) {
			app.radioStation4 = text;
		}
	}

	onShown: {
		espURL.inputText = app.espURL;

		radioStation1nr.inputText = app.radioStation1nr;
		radioStation2nr.inputText = app.radioStation2nr;
		radioStation3nr.inputText = app.radioStation3nr;
		radioStation4nr.inputText = app.radioStation4nr;

		radioStation1.inputText = app.radioStation1;
		radioStation2.inputText = app.radioStation2;
		radioStation3.inputText = app.radioStation3;
		radioStation4.inputText = app.radioStation4;

		enableSleepToggle.isSwitchedOn = app.enableSleep;

		addCustomTopRightButton("Save");
	}

	onCustomButtonClicked: {
		app.saveSettings();
		hide();
	}

	Text {
		id: myLabel
		text: "URL to Domoticz (example: http://192.168.10.65)"
		font.pixelSize:  isNxt ? 20 : 16
		font.family: qfont.regular.name

		anchors {
			left: parent.left
			top: parent.top			
			leftMargin: 20
			topMargin: 10
		}
	}

	EditTextLabel4421 {
		id: espURL
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 300
		leftText: "Domoticz URL"

		anchors {
			left: myLabel.left
			top: myLabel.bottom
			topMargin: 10
		}

		onClicked: {
			qkeyboard.open("URL to Domoticz incl. Port", espURL.inputText, saveespURL)
		}
	}

////////////////////////////////////////////////////////////////////////
	Text {
		id: myLabel229
		text: "Radio Nr (2 number \"01\" to \"09\"):"
		font.pixelSize:  isNxt ? 20 : 16
		font.family: qfont.regular.name

		anchors {
			left: parent.left
			top: espURL.bottom
			leftMargin: 20
			topMargin: 30
		}
	}

	EditTextLabel4421 {
		id: radioStation1nr
		width: (parent.width*0.37) - 40		
		height: 35
		leftTextAvailableWidth: 200
		leftText: "Radiostation 1 Nr"

		anchors {
			left: myLabel229.left
			top: myLabel229.bottom
			topMargin: 6
		}

		onClicked: {
			qkeyboard.open("Radiostation 1 Nr \"01\" to \"09\"", radioStation1nr.inputText, saveradioStation1nr)
		}
	}

	EditTextLabel4421 {
		id: radioStation2nr
		width: (parent.width*0.37) - 40
		height: 35
		leftTextAvailableWidth: 200

		leftText: "Radiostation 2 Nr"

		anchors {
			left: myLabel229.left
			top: radioStation1nr.bottom
			topMargin: 6
		}

		onClicked: {
			qkeyboard.open("Radiostation 2 Nr \"01\" to \"09\"", radioStation2nr.inputText, saveradioStation2nr)
		}
	}

	EditTextLabel4421 {
		id: radioStation3nr
		width: (parent.width*0.37) - 40
		height: 35
		leftTextAvailableWidth: 200
		leftText: "Radiostation 3 Nr"

		anchors {
			left: myLabel229.left
			top: radioStation2nr.bottom
			topMargin: 6
		}

		onClicked: {
			qkeyboard.open("Radiostation 3 Nr \"01\" to \"09\"", radioStation3nr.inputText, saveradioStation3nr)
		}
	}


	EditTextLabel4421 {
		id: radioStation4nr
		width: (parent.width*0.37) - 40
		height: 35
		leftTextAvailableWidth: 200
		leftText: "Radiostation 4 Nr"

		anchors {
			left: myLabel229.left
			top: radioStation3nr.bottom
			topMargin: 6
		}

		onClicked: {
			qkeyboard.open("Radiostation 4 Nr \"01\" to \"09\"", radioStation4nr.inputText, saveradioStation4nr)
		}
	}
///////////////////////////////////////////////////////////////////////////
	Text {
		id: myLabel22
		text: "Name (3 Letter, e.g. \"R10\"):"
		font.pixelSize:  isNxt ? 20 : 16
		font.family: qfont.regular.name

		anchors {
			left: radioStation1nr.right
			top: espURL.bottom
			leftMargin: 20
			topMargin: 30
		}
	}

	EditTextLabel4421 {
		id: radioStation1
		width: (parent.width*0.25) - 40
		height: 35
		leftTextAvailableWidth: 200

		anchors {
			left: myLabel22.left
			top: myLabel22.bottom
			topMargin: 6
		}

		onClicked: {
			qkeyboard.open("Radiostation 1 Name (3 Letter)", radioStation1.inputText, saveradioStation1)
		}
	}

	EditTextLabel4421 {
		id: radioStation2
		width: (parent.width*0.25) - 40
		height: 35
		leftTextAvailableWidth: 200

		anchors {
			left: myLabel22.left
			top: radioStation1.bottom
			topMargin: 6
		}

		onClicked: {
			qkeyboard.open("Radiostation 2 Name (3 Letter)", radioStation2.inputText, saveradioStation2)
		}
	}

	EditTextLabel4421 {
		id: radioStation3
		width: (parent.width*0.25) - 40
		height: 35
		leftTextAvailableWidth: 200

		anchors {
			left: myLabel22.left
			top: radioStation2.bottom
			topMargin: 6
		}

		onClicked: {
			qkeyboard.open("Radiostation 3 Name (3 Letter)", radioStation3.inputText, saveradioStation3)
		}
	}


	EditTextLabel4421 {
		id: radioStation4
		width: (parent.width*0.25) - 40
		height: 35
		leftTextAvailableWidth: 200

		anchors {
			left: myLabel22.left
			top: radioStation3.bottom
			topMargin: 6
		}

		onClicked: {
			qkeyboard.open("Radiostation 4 Name (3 Letter)", radioStation4.inputText, saveradioStation4)
		}
	}

	Text {
		id: showInSleep
		width:  160
		text: "Show in Sleepmode"
		font.pixelSize:  isNxt ? 20 : 16
		font.family: qfont.regular.name

		anchors {
			left: myLabel229.left
			top: radioStation4.bottom
			topMargin: 30
		}
	}

	OnOffToggle {
		id: enableSleepToggle
		height:  30
		anchors.left: showInSleep.right
		anchors.leftMargin: isNxt ? 65 : 30
		anchors.top: showInSleep.top
		leftIsSwitchedOn: false
		onSelectedChangedByUser: {
			if (isSwitchedOn) {
				app.enableSleep = true;
			} else {
				app.enableSleep = false;
			}
		}
	}


}

