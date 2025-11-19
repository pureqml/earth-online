Item {
	id: playerProto;
	signal finished;
	signal qualityListReady;
	property real duration;
	property real progress;
	property bool ready;
	property bool paused;
	property bool waiting;
	property string source;
	anchors.fill: parent;

	Timer {
		interval: 500;
		repeat: running;
		running: !parent.paused && parent.ready;

		onTriggered: {
			var node = playerProto.playerNode
			if (node)
				playerProto.progress = node.getCurrentTime()

			if (playerProto.duration && playerProto.progress >= playerProto.duration - 1)
				playerProto.finished()
		}
	}

	playerReady(event): {
		this.ready = true
		this.playerNode = event.target
	}

	seekTo(pos): {
		this.playerNode.seekTo(pos, false)
	}

	selectQuallity(quality): {
		log("select", quality)
		this.playerNode.setPlaybackQuality(quality.resolution)
	}

	playerStateChange(event): {
		switch (event.data) {
			case window.YT.PlayerState.PLAYING:
				this.waiting = false
				this.duration = event.target.getDuration()
				this.paused = false
				this.qualityList = event.target.getAvailableQualityLevels()
				playerProto.qualityListReady(this.qualityList)
				break
			case window.YT.PlayerState.PAUSED:
				this.waiting = false
				this.paused = true
				break
			case window.YT.PlayerState.BUFFERING:
				this.waiting = true
				break
			case window.YT.PlayerState.CUED:
				break
		}
	}

	onSourceChanged: {
		this.playVideoImpl()
	}

	playVideoImpl: {
		if (!this.source || !this.wasInit) {
			return
		}

		var videoId
		if (this.source.indexOf("http") == 0) {
			var splited = this.source.split("/")
			videoId = splited[splited.length - 1]
		} else {
			videoId = this.source
		}

		if (this.wasSetup) {
			this.playerNode.loadVideoById(videoId)
			return
		}
		var player
		var self = this
		this.paused = true
		this.ready = false

		window.YT.ready(function() {
			player = new window.YT.Player("yt-player", {
				width: self.width,
				height: self.height,
				videoId: videoId,
				playerVars: {
					end: 0, autoplay: 1, loop: 0, controls: 0, showinfo: 0, modestbranding: 1, fs: 0, cc_load_policty: 0, iv_load_policy: 3, autohide: 1, rel: 0
				},
				events: {
					onReady: self.playerReady.bind(self),
					onStateChange: self.playerStateChange.bind(self)
				}
			});
		}.bind(this))

		this.wasSetup = true
	}

	youTubeIframeAPIReady: {
		this.wasInit = true
		this.playVideoImpl()
	}

	pause: {
		this.playerNode.pauseVideo();
	}

	play: {
		this.playerNode.playVideo();
	}

	stop: {
		if (!this.playerNode)
			return

		this.source = ""
		this.playerNode.stopVideo();
	}

	onCompleted: {
		this.wasInit = false
		this.element.dom.id = "yt-player"

		this.element.setAttribute("pointer-events", "none")
		var tag = document.createElement('script')
		tag.src = "https://www.youtube.com/iframe_api"
		tag.async = false
		var self = this
		tag.onload = this._context.wrapNativeCallback(function(res) {
			self.youTubeIframeAPIReady()
		})
		var firstScriptTag = document.getElementsByTagName('script')[0]
		firstScriptTag.parentNode.insertBefore(tag, firstScriptTag)
	}
}
