Protocol {
	request(callback): {
		this.requestXHR({
			url: "https://api.wheretheiss.at/v1/satellites/25544",
			callback: callback,
			withCredentials: true
		})
	}
}
