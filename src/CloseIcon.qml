WebItem {
	property bool dispaly;
	width: 70;
	height: 70;
	anchors.top: parent.top;
	anchors.right: parent.right;
	visible: dispaly;

	ImageMixin { source: "res/close.png"; }

	Timer {
		id: dispalyTimer;
		interval: 5000;

		onTriggered: { this.parent.dispaly = false }
	}

	onDisplayChanged: {
		if (dispaly)
			this.keepAlive()
	}

	keepAlive: {
		dispalyTimer.restart()
		this.dispaly = true
	}
}
