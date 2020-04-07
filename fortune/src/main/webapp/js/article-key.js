// 主键按键事件
$('body').bind('keyup', function(event) {
    if (event.keyCode == "13") { // enter
    	$("#searchResult").show();
    	$("#updateDiv").hide();
    	$("#view").hide();
    	search();
    } else if(event.keyCode == '113') { // f2
        var href = window.location.href;
        if(href.indexOf('life.jsp') != -1) {
        	window.location = window.location.href.replace('life.jsp','article.jsp')
        } else if(href.indexOf('article.jsp')) {
        	window.location = window.location.href.replace('article.jsp','life.jsp')
        }
    }  else if(event.keyCode == '115') { // f4
        $('#folder').click();
    } else if(event.keyCode == '118') { // f7
        $('#toAdd').click();
        $("#category_name").focus();
        scrollToEdit();
    } else if(event.keyCode == '120') { // f8,f9
    	$('#submitBtn').click();
    } else if(event.altKey && event.keyCode == '67') { // alt c
    	$("#command").click();
    } else if(event.keyCode == '255') { // fn
    	$("#command").click();
    }
});

function scrollToEdit() {
	window.scrollTo(0,400);
}

// 左侧滚轮事件
$(function(){
	var whellIndex = 0;
	var index = 0;
	var first = true;
	var length = $("#menus span").length;
	document.getElementById('menus').onmousewheel = function() {
		if(whellIndex++ %2 != 0) {
			return;
		}
		if(first) {
			console.log('enter')
			first = false;
			setTimeout(function(){
				$("#menus span").filter('.b-red').click();
				$("#menus span").removeClass('b-red');
				index = 0;
				first = true;
			},2000)
		}
		$("#menus span").removeClass('b-red');
		$("#menus span:eq("+ ((index++)%length) +")").addClass('b-red');
	}
})

// 左侧点击事件
$(function(){
	$('#area,#menus').click(function() {
		$('.edui-for-paragraph .edui-arrow').click();
		$(".edui-listitem-body:eq(1)").click();
	});
	$('#area,#menus').dblclick(function() {
		$('.edui-for-paragraph .edui-arrow').click();
		$(".edui-listitem-body:eq(3)").click();
	});
})
