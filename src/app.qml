Item {
	anchors.fill: context;

	YouTube {
		anchors.fill: parent;
		source: "https://www.youtube.com/embed/ddFvjfvPnqk?autoplay=1&controls=0&showinfo=0";
	}

	Osd { id: osd; }

	WebItem {
		width: 50;
		height: 50;
		anchors.top: parent.top;
		anchors.left: parent.left;

		Image {
			anchors.fill: parent;
			source: osd.active ? "res/close.png" : "res/earth.png";
		}

		onClicked: { osd.active = !osd.active }
	}
}
