WebItem {
	property bool active: false;
	anchors.fill: parent;
	opacity: active ? 1.0 : 0.0;

	IssProtocol { id: protocol; }

	Rectangle {
		anchors.fill: parent;
		color: "#000";
		opacity: 0.5;
	}

	IssMap { id: map; anchors.centerIn: parent; }

	Text {
		id: hintText;
		anchors.right: parent.right;
		anchors.bottom: parent.bottom;
		anchors.margins: 10;
		font.pixelSize: 24;
		font.family: "Space Mono";
		color: "#fff";
		text: "Earth visibility: -";
	}

	Text {
		id: positionText;
		anchors.left: parent.left;
		anchors.bottom: parent.bottom;
		anchors.margins: 10;
		font.pixelSize: 24;
		font.family: "Space Mono";
		color: "#fff";
		text: "Lon: -<br>Lat: -";
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
		hintText.text = "Earth visibility: " + data.visibility
		map.setPos(long, lat)
	}

	updatePositionRequest: {
		var self = this
		protocol.request(function(res) {
			var data = JSON.parse(res.target.response)
			if (data)
				self.doUpdatePosition(data)
			else
				log("Request error")
		})
	}

	hide: { this.active = false }
	show: { this.active = true }

	Behavior on opacity { Animation { duration: 300; } }
}
