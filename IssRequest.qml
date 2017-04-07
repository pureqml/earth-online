Request {
	call(callback): {
		this.ajax({
			url: "https://api.wheretheiss.at/v1/satellites/25544",
			done: callback,
			withCredentials: true
		})
	}
}
