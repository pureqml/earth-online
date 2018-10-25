Request {
	property bool networkProblems;

	call(callback): {
		var self = this
		this.ajax({
			url: "https://api.wheretheiss.at/v1/satellites/25544",
			done: function(res) { self.networkProblems = false; callback(res) },
			error: function(res) { self.networkProblems = true },
			withCredentials: true
		})
	}
}
