Item {
	anchors.fill: context;

	Image {
		anchors.fill: parent;
		source: "res/map.png";

		Rectangle {
			id: station;
			x: -width;
			y: -height;
			width: 30;
			height: width;
			radius: width / 2;
			color: "red";
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

		station.x = x
		station.y = y
	}
}
