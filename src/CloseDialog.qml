Rectangle {
	id: closeDialogProto;
	signal accepted;
	signal canceled;
	width: 40%;
	height: 30%;
	anchors.centerIn: parent;
	color: "#424242";
	visible: false;

	Text {
		x: 5%;
		y: 30%;
		width: 90%;
		text: "Are you really want to close the app?";
		wrapMode: Text.WordWrap;
		font.pixelSize: 32;
		horizontalAlignment: Text.AlignHCenter;
		color: "#fff";
	}

	Row {
		id: buttonsRow;
		y: 76%;
		width: 96%;
		height: 20%;
		anchors.horizontalCenter: parent.horizontalCenter;

		WebItem {
			width: 50%;
			height: 100%;
			focus: true;
			border.width: activeFocus ? 3 : 0;
			border.type: Border.Outer;
			border.color: "#fff";

			Text {
				width: 100%;
				anchors.verticalCenter: parent.verticalCenter;
				text: "Yes";
				font.pixelSize: 32;
				horizontalAlignment: Text.AlignHCenter;
				color: "#fff";
			}

			process: { closeDialogProto.hide(); closeDialogProto.accepted() }

			onClicked: { this.process() }
			onSelectPressed: { this.process() }
		}

		WebItem {
			id: noButton;
			width: 50%;
			height: 100%;
			focus: true;
			border.width: activeFocus ? 3 : 0;
			border.type: Border.Outer;
			border.color: "#fff";

			Text {
				width: 100%;
				anchors.verticalCenter: parent.verticalCenter;
				text: "No";
				font.pixelSize: 32;
				horizontalAlignment: Text.AlignHCenter;
				color: "#fff";
			}

			process: { closeDialogProto.hide(); closeDialogProto.canceled() }

			onClicked: { this.process() }
			onSelectPressed: { this.process() }
		}
	}

	show: { this.visible = true }
	hide: { this.visible = false }

	onBackPressed: { this.hide() }

	onVisibleChanged: { if (value) noButton.setFocus() }
}
