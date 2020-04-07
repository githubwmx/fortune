
function defaultFormatter(val) {
	if(val == null || val == undefined) {
		return '';
	}
	return val;
}

Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1,
		"d+" : this.getDate(),
		"H+" : this.getHours(),
		"m+" : this.getMinutes(),
		"s+" : this.getSeconds(),
		"q+" : Math.floor((this.getMonth() + 3) / 3),
		"S" : this.getMilliseconds()
	};
	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}
	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
		}
	}
	return format;
};

function dateFormat(val) {
	if (!val) {
		return '';
	}
	return new Date(val).format("yyyy-MM-dd HH:mm:ss");
}
function dateFormatYMD(val) {
	if (!val) {
		return '';
	}
	return new Date(val).format("yyyy-MM-dd");
}
