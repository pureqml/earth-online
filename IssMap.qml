Item {
	anchors.fill: context;

	Image {
		anchors.fill: parent;
		fillMode: Image.Stetch;
		source: "res/map.png";

		Rectangle {
			id: station;
			width: 30;
			height: width;
			radius: width / 2;
			color: "red";
			visible: false;

			Behavior on x, y { Animation { duration: 10000; easing: "linear"; } }
		}
	}

	setPos(long, lat): {
		var w = this.width
		var h = this.height

		var earthLong = 360
		var earthLat = 180

		var x = long + earthLong / 2
		var y = earthLat / 2 - lat

		x *= w / earthLong
		y *= h / earthLat

		x -= w / 28.4
		y += h / 19.45

		station.visible = true
		station.x = x
		station.y = y
	}
}
