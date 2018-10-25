WebItem {
	id: osdProto;
	property bool active: false;
	property bool mobile: context.system.device == System.Mobile;
	property bool networkProblems: request.networkProblems;
	width: mobile && !active ? 50 : context.width;
	height: mobile && !active ? 50 : context.height;
	anchors.top: parent.top;
	anchors.left: parent.left;
	opacity: active ? 1.0 : 0.0;

	IssRequest { id: request; }

	IssMap { id: map; }

	Text {
		id: positionText;
		anchors.left: parent.left;
		anchors.bottom: parent.bottom;
		anchors.margins: 10;
		font.pixelSize: 24;
		color: "#fff";
		text: "Lon: -<br>Lat: -<br>Visibility: -";
	}

	Timer {
		running: parent.active;
		triggeredOnStart: true;
		interval: 10000;
		repeat: true;

		onTriggered: { this.parent.updatePositionRequest() }
	}

	doUpdatePosition(data): {
		var long = parseFloat(data.longitude)
		var lat = parseFloat(data.latitude)
		positionText.text = "Lon: " + Number((long).toFixed(1)) + "<br>Lat: " + Number((lat).toFixed(1))
		positionText.text += "<br>Visibility: " + data.visibility
		map.setPos(long, lat)
	}

	updatePositionRequest: {
		var self = this
		request.call(function(res) {
			var data = JSON.parse(res.target.response)
			if (data)
				self.doUpdatePosition(data)
			else
				log("Request error")
		})
	}

	Behavior on opacity { Animation { duration: osdProto ? 0 : 300; } }
}
