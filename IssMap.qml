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
			height: 30;
			radius: width / 2;
			color: "red";
		}
	}

	setPos(long, lat): {
		station.x = (long + 180) * this.width / 360 - (this.width / 28.4)
		station.y = (90 - lat) * this.height / 180 + (this.height / 19.45)
	}
}
