Item {
	anchors.fill: context;
	focus: true;

	YouTube {
		anchors.fill: parent;
		source: "https://www.youtube.com/embed/RtU_mdL2vBM?autoplay=1&controls=0&showinfo=0";
	}

	Osd {
		id: osd;

		toggleActive: { osd.active = !osd.active }
		onClicked: { this.toggleActive() }
	}

	WebItem {
		width: 50;
		height: 50;
		anchors.top: parent.top;
		anchors.left: parent.left;
		visible: osd.mobile;

		Image {
			anchors.fill: parent;
			source: osd.active ? "res/close.png" : "res/earth.png";
		}

		onClicked: { osd.toggleActive() }
	}

	onSelectPressed: { osd.toggleActive() }

	onBackPressed: {
		if (osd.active)
			osd.toggleActive()
		else
			_globals.closeApp()
	}
}
