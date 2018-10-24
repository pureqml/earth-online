Item {
	anchors.fill: context;
	focus: true;

	VideoPlayer {
		id: player;
		anchors.fill: parent;
		autoPlay: true;
		source: "http://iphone-streaming.ustream.tv/uhls/17074538/streams/live/iphone/playlist.m3u8";
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
