import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0;

Screen {
	id: onkyosocketScreen
	screenTitle: "Onkyo Controller"
	property int butHeight : 50

	onShown: {
		addCustomTopRightButton("Instellingen");
        	app.sendwebsock("NATQSTN");         
        	app.sendwebsock("NTMQSTN");        
        	app.sendwebsock("MVLQSTN");         
        	app.sendwebsock("SLIQSTN");         
        	app.sendwebsock("TUNQSTN");         
        	app.sendwebsock("NSTQSTN");         
        	app.sendwebsock("NALQSTN");         
        	app.sendwebsock("PWRQSTN");         
        	app.sendwebsock("PRSQSTN");
	}

	onCustomButtonClicked: {
		if (app.onkyosocketConfigScreen) {app.onkyosocketConfigScreen.show()};
	}

		NewTextLabel {
			id: powerlabel
			width: 1019; height: butHeight
			buttonActiveColor: !app.actPower? "grey" : "red"
			buttonHoverColor: "blue"
			buttonDisabledColor: "lightgray"
			enabled : true
			textColor : "black"
			textDisabledColor : "grey"
			buttonText: !app.actPower? "Power": "Power Off"
			anchors {
				left: parent.left
				leftMargin: 5
            		}
			onClicked:!app.actPower? app.sendwebsock("PWR01")  : app.sendwebsock("PWR00")
		}


		NewTextLabel {
			id: selectorlabel1
			width: 140; height: butHeight
			buttonActiveColor: (app.actAirplay) ? "red" : "grey"
			buttonHoverColor: "green"
			buttonDisabledColor: "lightgray"
			enabled : true
			textColor : "black"
			textDisabledColor : "grey"
			buttonText: "Airplay"
			anchors {
				top: parent.top
				topMargin: 50
				right: selectorlabel2.left
				rightMargin: 6
            		}
			onClicked:{app.sendwebsock("SLI2D");}
		}

		NewTextLabel {
			id: selectorlabel2
			width: 140; height: butHeight
			buttonActiveColor: (app.actAirplay) ? "red" : "grey"
			buttonText: "Aux"
			anchors {
				top: selectorlabel1.top
				right: selectorlabel3.left
				rightMargin: 6
            		}
			onClicked: {app.sendwebsock("SLI03");}
		}

		NewTextLabel {
			id: selectorlabel3
			width: 140; height: butHeight
			buttonActiveColor: (app.actFM) ? "red" : "grey"
			buttonText: "FM"
			anchors {
				top: selectorlabel1.top
				right: selectorlabel4.left
				rightMargin: 6
            		}
			onClicked: {app.sendwebsock("SLI24");}
		}

		NewTextLabel {
			id: selectorlabel4
			width: 140; height: butHeight
			buttonActiveColor: (app.actTV) ? "red" : "grey"
			buttonText: "TV"
			anchors {
				top: selectorlabel1.top
				horizontalCenter: powerlabel.horizontalCenter
            		}
			onClicked: {app.sendwebsock("SLI12");}
		}

		NewTextLabel {
			id: selectorlabel5
			width: 140; height: butHeight
			buttonActiveColor: (app.actPhono) ? "red" : "grey"
			buttonText: "Phono"
			anchors {
				top: selectorlabel1.top
				left: selectorlabel4.right
				leftMargin: 6
            		}
			onClicked: {app.sendwebsock("SLI22");}
		}

		NewTextLabel {
			id: selectorlabel6
			width: 140; height: butHeight
			buttonActiveColor: (app.actNET) ? "red" : "grey"
			buttonText: "NET"
			anchors {
				top: selectorlabel1.top
				left: selectorlabel5.right
				leftMargin: 6
            		}
			onClicked: {app.sendwebsock("SLI2B");}
		}

		NewTextLabel {
			id: selectorlabel7
			width: 140; height: butHeight
			buttonActiveColor: (app.actBT) ? "red" : "grey"
			buttonText: "BT"
			anchors {
				top: selectorlabel1.top
				left: selectorlabel6.right
				leftMargin: 6
            		}
			onClicked: {app.sendwebsock("SLI2E");}
		}


	//volume control session start here, first you'll find the first button.
		NewTextLabel {
			id: selectorlabel11
			width: 140; height: butHeight
			buttonActiveColor: "grey"
			buttonText: "VOL -"
			anchors {
				bottom: parent.bottom
				bottomMargin: 5
				right: selectorlabel12.left
				rightMargin: 6
            		}
			onClicked: {app.sendwebsock("MVLDOWN1");}
			visible: app.actPower
		}


		NewTextLabel {
			id: selectorlabel12
			width: 140; height: butHeight
			buttonActiveColor: "grey"
			buttonText: "Prev"
			anchors {
				top: selectorlabel11.top
				right: selectorlabel13.left
				rightMargin: 6
            		}
			onClicked:app.actFM? app.sendwebsock("PRSDOWN")  : app.sendwebsock("NTCTRDN")
			visible: app.actPower && (app.actBT || app.actAirplay || app.actNET || app.actFM)
		}


		NewTextLabel {
			id: selectorlabel13
			width: 140; height: butHeight
			buttonActiveColor: "grey"
			buttonText: "Play"
			anchors {
				top: selectorlabel11.top
				right: selectorlabel14.left
				rightMargin: 6
            		}
			onClicked: {app.sendwebsock("NTCPAUSE");}
			visible: app.actPower && (app.actBT || app.actAirplay || app.actNET)

		}


		NewTextLabel {
			id: selectorlabel14
			width: 140; height: butHeight
			buttonActiveColor:  "grey"
			buttonText: "Stop"
			anchors {
				top: selectorlabel11.top
				horizontalCenter: powerlabel.horizontalCenter
            		}
			onClicked: {app.sendwebsock("NTCSTOP");}
			visible: app.actPower && (app.actBT || app.actAirplay || app.actNET)
		}

		NewTextLabel {
			id: selectorlabel15
			width: 140; height: butHeight
			buttonActiveColor: "grey"
			buttonText: "Random"
			anchors {
				top: selectorlabel11.top
				left: selectorlabel14.right
				leftMargin: 6
            		}
			onClicked: {app.sendwebsock("NTCRANDOM");}
			visible: app.actPower && (app.actBT || app.actAirplay || app.actNET)
		}


		NewTextLabel {
			id: selectorlabel16
			width: 140; height: butHeight
			buttonActiveColor:  "grey"
			buttonText: "Next"
			anchors {
				top: selectorlabel11.top
				left: selectorlabel15.right
				leftMargin: 6
            		}
			onClicked:app.actFM? app.sendwebsock("PRSUP")  : app.sendwebsock("NTCTRUP")
			visible: app.actPower && (app.actBT || app.actAirplay || app.actNET || app.actFM)
		}


		NewTextLabel {
			id: selectorlabel17
			width: 140; height: butHeight
			buttonActiveColor:  "grey"
			buttonText: "Vol +"
			anchors {
				top: selectorlabel11.top
				left: selectorlabel16.right
				leftMargin: 6
            		}
			onClicked: {app.sendwebsock("MVLUP1");}
			visible: app.actPower
		}

/////////////////////////////////////////////////////////////////////////////////////// End of playbuttons section
	Image {
		id:albumArt
		width: 250; height: 250
		source: app.imageURL
		anchors {
			baseline:  itemText.top
			left: powerlabel.left
			leftMargin: 30
		}
		visible: app.actPower && (app.actBT || app.actAirplay|| app.actNET)
	}

	Rectangle {
		id: itemText
		color: "transparent"
		width: parent.width - albumArt.width - volBar.barWidth - 120; height: 120  		
		Text{
			id: iText
			width: parent.width
			font.pixelSize: 30
			wrapMode: Text.WordWrap
         		text: !app.actFM ? app.actualArtist : "Radio Preset: " + app.actualPreset;
			font.family: qfont.regular.name
			font.bold: true
			color: "black"
			anchors.bottom: parent.bottom
			anchors.horizontalCenter: parent.horizontalCenter 
     		}
		anchors {
			top: selectorlabel1.bottom
			left: albumArt.right
			topMargin: 20
			leftMargin: 30
            	}
		visible: app.actPower && (app.actBT || app.actAirplay || app.actNET || app.actFM)
	}

	Rectangle {
		id: titleText
		color: "transparent"
		width: itemText.width; height: 120     		
		Text{
			id: tText
			width: parent.width
			font.pixelSize: 30 
			wrapMode: Text.WordWrap 
         		text: !app.actFM ? app.actualTitle : "Radio Frequency: " + app.actualTuner;
			font.family: qfont.regular.name
			font.bold: true
			color: "black"
			anchors.top: parent.top
			anchors.horizontalCenter: parent.horizontalCenter     		
		}
		anchors {
			top: itemText.bottom
			left: itemText.left
			topMargin: 10
            	}
		visible: app.actPower && (app.actBT || app.actAirplay || app.actNET || app.actFM)
	}


	Text {
		id:timeText
		width: parent.width
		text: app.actualPlaytime
		font.pixelSize:  22
		font.family: qfont.regular.name
		font.bold: false
		color: colors.clockTileColor
		wrapMode: Text.WordWrap
		anchors {
			left: itemText.left
			top: titleText.bottom
			topMargin: 30
		}
		visible: app.actPower && (app.actBT || app.actAirplay || app.actNET)
	}

	NewBargraph {
		id: volBar
		maxValue :100
		value: app.actualVolume        
		barHeight : 210
		barWidth : 50
		anchors {
			top:  itemText.top
			right: selectorlabel7.right
			rightMargin : 30
		}
    	visible: app.actPower
	} 
	
}

