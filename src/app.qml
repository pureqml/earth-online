Item {
	anchors.fill: context;
	focus: true;

	YouTube {
		id: player;
		anchors.fill: parent;
		source: "https://www.youtube.com/embed/UQt2iLKqBbI?autoplay=1&controls=0&showinfo=0";
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

	MouseMoveMixin { onMouseMove: { closeIcon.keepAlive() } }

	CloseIcon {
		id: closeIcon;

		onClicked: { approoveDialog.show() }
	}

	CloseDialog {
		id: approoveDialog;

		onAccepted: { _globals.closeApp() }
	}

	onSelectPressed: { osd.toggleActive() }

	onBackPressed: {
		if (osd.active)
			osd.toggleActive()
		else
			approoveDialog.show()
	}
}
