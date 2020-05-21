//
// OnkyoSocket by Oepi-Loepi
//

import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0;
import ScreenStateController 1.0
import FileIO 1.0
import QtWebSockets 1.1

App {
	id: onkyosocketApp

	property url tileUrl : "OnkyosocketTile.qml"
	property url thumbnailIcon: "qrc:/tsc/onkyo-resize.png"

	property url onkyosocketConfigScreenUrl : "OnkyosocketConfigScreen.qml"
	property OnkyosocketConfigScreen onkyosocketConfigScreen

	property url onkyosocketScreenUrl : "OnkyosocketScreen.qml"
	property OnkyosocketScreen onkyosocketScreen

	
	property string	statnrHEX
	property string actualArtist
	property string actualTitle
	property string oldTitle
	property string oldArtist
	property string actualPlaytime
	property string actualSelector : "2B"
	property string actualPower
	property string actualStation
	property string actualPreset
	property string actualTuner

	property string actualVolume

	property bool actualArtistLong : false
	property bool actualTitleLong : false
	property bool actSelector : false
	property bool actPower : true

	property bool actFM : false
	property bool actPhono : false
	property bool actAux : false
	property bool actTV : false
	property bool actBT : false
	property bool actAirplay : false
	property bool actNET : true

	property bool showButtons : false
	property bool enableSleep : false
	property bool webSocketactive : true
	property bool socketerror : false

	property string socketURL : "ws://192.168.10.65:81"
	property string imageURL : "http://192.168.10.241/album_art.cgi"
        property string espURL: "http://192.168.10.65"

	property string radioStation1nr : "03"
	property string radioStation2nr : "04"
	property string radioStation3nr : "06"
	property string radioStation4nr : "08"

	property string radioStation1 : "R10"
	property string radioStation2 : "Q"
	property string radioStation3 : "3FM"
	property string radioStation4 : "538"
	property string tmpSleep : "No"


	// user settings from config file
	property variant onkyosocketSettingsJson : {
		'socketURL': "",
		'radioStation1nr': "",
		'radioStation2nr': "",
		'radioStation3nr': "",
		'radioStation4nr': "",

		'radioStation1': "",
		'radioStation2': "",
		'radioStation3': "",
		'radioStation4': "",
		'tmpSleep': ""
	}


	FileIO {
		id: onkyosocketSettingsFile
		source: "file:///mnt/data/tsc/onkyosocket_userSettings.json"
 	}

   	WebSocket {
        	id: socket
        	url: socketURL 
       		onTextMessageReceived: {
 	    		writewebsockettovars(message)
        	}
        	onStatusChanged: 
		if (socket.status == WebSocket.Error) {
                     socketerror = true
                } else if (socket.status == WebSocket.Open) {
                     socket.sendTextMessage("This is Toon for ESP")
                } else if (socket.status == WebSocket.Closed) {
                }
        	active:webSocketactive
    	}


	function init() {
		registry.registerWidget("tile", tileUrl, this, null, {thumbLabel: qsTr("OnkyoSocket"), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, thumbIconVAlignment: "center"});
		registry.registerWidget("screen", onkyosocketConfigScreenUrl, this, "onkyosocketConfigScreen");
        registry.registerWidget("screen", onkyosocketScreenUrl, this, "onkyosocketScreen");
	}


	function sendwebsock(socketmessage) {
		socket.sendTextMessage(socketmessage)
	}


	function writewebsockettovars(webmessage) {
	try {
		var JsonObject4= JSON.parse(webmessage);

		actualPower = JsonObject4['power1'];

		if ((actualPower == '01') || (actualPower == "01")) {
			actPower = true;
		}else{
			actPower = false;
			actualTitle = "";
			actualArtist = "";
		}

		actualSelector = JsonObject4['input'];
		actualTitle = JsonObject4['title'];
		actualArtist = JsonObject4['artist'];
		actualPlaytime = JsonObject4['timestamp'];
		actualVolume = JsonObject4['volume'];
		actualPreset = JsonObject4['preset'];
		actualTuner = JsonObject4['tuner'];

		//24 = radio, 22 phono, 2d airplay, 2e bt, 2b netwerk, 12 tv
		actFM = false;
		actPhono = false;
		actAux = false;
		actTV = false;
		actBT = false;
		actAirplay = false;
		actNET = false;

		switch (actualSelector) {

			case "24": {
				actFM=true;
				break;
			}
			case "22": {
				actPhono=true;
				actualTitle = "";
				actualArtist = "";
				break;
			}
			case "2D": {
				actAirplay=true;
				break;
			}
			case "2E": {
				actBT=true;
				break;
			}
			case "2B": {
				actNET=true;
				break;
				}
			case '2B': {
				actNET=true;
				break;
				}

			case "12": {
				actTV=true;
				actualTitle = "";
				actualArtist = "";
				break;
			}
			 case "03": {
				actAUX=true;
				actualTitle = "";
				actualArtist = "";
				break;
			}
			default: {
				break;
			}
		}

		if (actualTitle.length > 22) {
			actualTitleLong = true;
		}else{
			actualTitleLong = false;
		}

		if (actualArtist.length > 22) {
			actualArtistLong = true;
		}else{
			actualArtistLong = false;
		}

		//if ((actualTitle != oldTitle)||(actualArtist != oldArtist)){
		//	imageURL = "http://192.168.10.241/album_art.cgi?" +  Math.random();
		//	oldTitle = actualTitle;
		//	oldArtist = actualArtist;
	//
		//}


	} catch(e) {
	}

	}
	
	Component.onCompleted: {
		try {
			onkyosocketSettingsJson = JSON.parse(onkyosocketSettingsFile.read());
			if (onkyosocketSettingsJson['tmpSleep'] == "Yes") {
				enableSleep = true
			} else {
				enableSleep = false
			}

			socketURL = onkyosocketSettingsJson['socketURL'];

			radioStation1nr = onkyosocketSettingsJson['radioStation1nr'];
			radioStation2nr = onkyosocketSettingsJson['radioStation2nr'];
			radioStation3nr = onkyosocketSettingsJson['radioStation3nr'];
			radioStation4nr = onkyosocketSettingsJson['radioStation4nr'];

			radioStation1 = onkyosocketSettingsJson['radioStation1'];
			radioStation2 = onkyosocketSettingsJson['radioStation2'];
			radioStation3 = onkyosocketSettingsJson['radioStation3'];
			radioStation4 = onkyosocketSettingsJson['radioStation4'];

		
		} catch(e) {
		}
	}


	function saveSettings() {

		if (enableSleep == true) {
			tmpSleep = "Yes";
		} else {
			tmpSleep = "No";
		}

 		var setJson = {
			"socketURL" : socketURL,

			"radioStation1nr" : radioStation1nr,
			"radioStation2nr" : radioStation2nr,
			"radioStation3nr" : radioStation3nr,
			"radioStation4nr" : radioStation4nr,

			"radioStation1" : radioStation1,
			"radioStation2" : radioStation2,
			"radioStation3" : radioStation3,
			"radioStation4" : radioStation4,
			"tmpSleep" : tmpSleep
		}
  		var doc3 = new XMLHttpRequest();
   		doc3.open("PUT", "file:///mnt/data/tsc/onkyosocket_userSettings.json");
   		doc3.send(JSON.stringify(setJson));
	}

	Timer {
		id:socketreconnectTimer
		interval: 60000
		triggeredOnStart: true
		running: true
		repeat: true
		onTriggered: {webSocketactive = false; webSocketactive = true}
	}

	Timer {
		id:imageRefreshTimer
		interval: 3000
		running: (actualTitle != oldTitle)
		onTriggered: imageURL = "http://192.168.10.241/album_art.cgi?" +  Math.random()
	}

}
