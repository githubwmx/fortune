var config = {
		toAddFixCategoryName: ""
}
$('body').bind('keyup', function(event) {
    if (event.keyCode == "13") { // enter
    	$("#searchResult").show();
    	$("#updateDiv").hide();
    	search();
    } else if(event.keyCode == '113') { // f2
    	toggleUrl();
    } else if(event.keyCode == '118') { // f7
        $('#toAdd').click();
        $("#category_name").val(config.toAddFixCategoryName);
    } else if(event.keyCode == '119') { // f8
        $('#submitBtn').click();
    } else if(event.keyCode == '120') { // f9
        $('#updateBtn').click();
    } else if(event.keyCode == '37') { // left
    	forSpan(1);
    } else if(event.keyCode == '39') { // right
    	forSpan(2);
    }
});

function forSpan(flag) {
	var spans = $("#labels span");
	var selected = spans.filter('.selected');
	
	if(selected && selected.length>0) {
		selected.removeClass('selected');
		if(flag == 1) { // 向左
			 $(selected[0]).prev().addClass("selected").click();
		} else { // 向右
			$(selected[0]).next().addClass("selected").click();
		}	
	} else { // 无选中
		$(spans[0]).addClass("selected").click();
	}
}

$(function(){
	$("#keyword").bind('keyup',function(){
		event.preventDefault();
		autoSearch()
	})
})

function autoSearch() {
	var keyword = $("#keyword").val();
	if(keyword && keyword.length>=2) {
		$("#categories span").each(function(){
			var text = $(this).text();
			text = text.replace(/(\(\)|\[\]|\[\]\[\]|\★|\@|\@\@)/g,'');
			if(text.startsWith(keyword)) {
				$(this).click();
			}
		});
	}
}

function toggleUrl() {
    var href = window.location.href;
    if(href.indexOf('life.jsp') != -1) {
        window.location = window.location.href.replace('life.jsp','article.jsp')
    } else if(href.indexOf('article.jsp')) {
        window.location = window.location.href.replace('article.jsp','life.jsp')
    }
}