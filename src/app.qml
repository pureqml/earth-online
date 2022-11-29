Item {
	anchors.fill: context;
	focus: true;

	YouTube {
		id: player;
		anchors.fill: parent;
		source: "https://www.youtube.com/embed/ddZu_1Z3BAc?autoplay=1&controls=0&showinfo=0&cc_load_policy=3";
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

	Text {
		anchors.top: parent.top;
		anchors.left: parent.left;
		anchors.margins: 10;
		text: "CONNECTION PROBREMS";
		font.pixelSize: 24;
		color: "#F44336";
		visible: osd.networkProblems;
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

	onCompleted: {
		this._context.document.on('visibilitychange', function() {
			log("app visibility", document.hidden)
			if (document.hidden) {
				// player.pause()
			} else {
				// player.play()
				if (window.webapis && window.webapis.appcommon) {
					window.webapis.appcommon.setScreenSaver(
						window.webapis.appcommon.AppCommonScreenSaverState.SCREEN_SAVER_OFF,
						function(result) { log("Turn scrren saver off success", result); },
						function(error) { log("Failed to turn screen saver off", JSON.stringify(error)); }
					);
				}
			}
		});
	}
}
