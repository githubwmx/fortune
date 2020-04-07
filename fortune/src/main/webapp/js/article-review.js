var reviewConfig = {
		number: 25
}
$(function() {
	getCurrent();
})

function getCurrent() {
	var reviewArray = localStorage.getItem('reviewArray');
	if(!reviewArray) {
		reviewArray = getAndStore();
	} else {
		reviewArray = fromJson(reviewArray);
	}
	renderPanel(reviewArray[0], reviewArray.length);
}

function nextReview() {
	var reviewArray = fromJson(localStorage.getItem('reviewArray'));
	if(reviewArray.length <= 1) { // 只剩当前题了,重新拉取
		var reviewArray = getAndStore();
		renderPanel(reviewArray[0], reviewArray.length)
	} else {
		renderPanel(reviewArray[1], reviewArray.length-1)
		var newArray = reviewArray.slice(1, reviewArray.length);
		localStorage.setItem('reviewArray', toJson(newArray));
	}
}

function getAndStore() {
	$.ajax({
		url : 'http://localhost:9000/article/getReview',
		data : {
			number: reviewConfig.number
		},
		type : 'get',
		dataType : 'json',
		contentType : "application/json; charset=utf-8",
		async : false,
		cache : false,
		success : function(json) {
			localStorage.setItem('reviewArray', toJson(json.list));
			localStorage.setItem('reviewArrayCount', json.count);
		}
	});
	return fromJson(localStorage.getItem('reviewArray'));
}

function renderPanel(review, remainCount) {
	var count = localStorage.getItem('reviewArrayCount');
	$('#review #view-title').html(spanRed(review.category_name) + " " + review.title);
	$('#review #view-content').html(review.content);
	$('#review #tooltip').html("共"+count+"题,还剩"+remainCount+"题");
}

function emptyPanel() {
	$('#review #view-title').html("");
	$('#review #view-content').html("");
	$('#review #tooltip').html("还剩0题");	
}
