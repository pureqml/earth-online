Item {
	anchors.fill: context;

	Youtube {
		anchors.fill: parent;
		source: "https://www.youtube.com/embed/ddFvjfvPnqk?autoplay=1&controls=0&showinfo=0";
	}

	Osd {
		onClicked: { this.active = !this.active }
	}
}
