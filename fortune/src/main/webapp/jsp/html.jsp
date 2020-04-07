<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include-base.jsp"%>
<%@ include file="include-bootstrap.jsp"%>		
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="<%=basePath %>css/common.css"/>
    <title>html生成</title>

<style type="text/css">
body {
	font-size: 16px !important;
}
.container {
	width:99%;
}
#props span {
    width: 100px;
    display: inline-block;
    font-weight: bold;
}
xmp {
    padding: 5px;
    border: 1px solid lightgray;
}
</style>
</head>
<body style="padding: 10px;">
<div class="container">
    <div id='props' class='col-lg-3'>
		 <span>id:</span>
		 <input type="text" name='id' autofocus></input>
         <br/><br/>
         		 
		 <span>name:</span>
		 <input type="text" name='name'></input>
		 <br/><br/>
		 
		 <span>class:</span>
		 <select name='class'>
            <option value="">---</option>            		 
            <option value="container">container</option>            		 
		 </select>
		 <br/><br/>

         <span>value:</span>
         <input type="text" name='value'></input>
         <br/><br/>

         <span>label:</span>
         <input type="text" id='label'></input>
         <br/><br/>
		 
		 <span>type:</span>
         <select name='type'>
              <option></option>
              <option value='radio'>radio</option>
              <option value='checkbox'>checkbox</option>
              <option value='button'>button</option>
              <option value='submit'>submit</option>
              <option value='password'>password</option>
         </select>
         <br/><br/>
         
		 <span>width:</span>
		 <select name='width'>
		      <option></option>
		      <option value="200px">200px</option>
		      <option value="400px">400px</option>
		      <option value="600px">600px</option>
		      <option value="800px">800px</option>
		      <option value="1000px">1000px</option>
		      <option value="1200px">1200px</option>
		      <option value="1400px">1400px</option>
		      <option value="1600px">1600px</option>
		      <option value="50%">50%</option>
		      <option value="80%">80%</option>
		 </select>
		 <br/><br/>
		 
		 <span>width:</span>
		 <input type="text" name='width'></input>
         <br/><br/>
		 
		 <span>height:</span>
		 <select name='height'>
		      <option></option>
              <option value="200px">200px</option>
              <option value="400px">400px</option>
              <option value="600px">600px</option>
         </select>
         <br/><br/>
         
         <span>height:</span>
         <input type="text" name='height'></input>
		 <br/><br/> 
    </div>
	<div id='results' class='col-lg-9'>
	    
	</div> 
</div>
</body>
<script>
$('body').bind('keyup', function(event) {
    if (event.keyCode == "13") {
    	generate();
    }
});
$(function(){
	$('select,input').bind('change',function(){
		generate();
	});
})
var domConfig = {
		'input':['id','name','type','width','value'],
		'textarea':['id','name','width','height'],
		'div':['class']
}
var cssArray = ['width','height'];
function generate() {
	$("#results").empty();
	var props = $('#props input,#props select');
	var map = {};
	for(var i=0;i<props.length;i++) {
		var $input = $(props[i]);
		if($input.val()) {
			map[$input.attr('name')] = $input.val();
		}
	}
    for(var tag in domConfig) {
        var $newDom = $("<"+tag+">");
    	var acceptProps = domConfig[tag];
    	var isCheckbox = false;
        for(var i=0;i<acceptProps.length;i++) {
            var acceptProp = acceptProps[i];
            if(map[acceptProp]) {
            	if($.inArray(acceptProp, cssArray) != -1) {
            		$newDom.css(acceptProp, map[acceptProp]);
            	} else if(acceptProp == 'value') {
                    $newDom.val(map[acceptProp]);
                } else {
            	    $newDom.attr(acceptProp, map[acceptProp]);
            	}
            }
        }
        $("#results").append($newDom);
        var html = '';
        if(tag == 'input' && ($("[name='type']").val() == 'checkbox' || $("[name='type']").val() == 'radio')) {
	        var $label = $('<label for="'+$newDom.attr('name')+'">'+$('#label').val()+'</label>');
        	$($newDom).before($label);
        	html += $label[0].outerHTML;
        } else if(tag == 'div') {
        	$newDom.addClass('init-div');
        }
        var $xmp = $('<xmp>');
        $xmp.html(html + $newDom[0].outerHTML);
        $("#results").append($xmp);
        $("#results").append('<div class="border-red mb10"/>');
        $xmp.bind('click',function(){
        	copy($(this).text());
        })
    }
}
function copy (str) {
    let oInput = document.createElement('textarea');
    oInput.value = str
    document.body.appendChild(oInput)
    oInput.select()
    document.execCommand("Copy")
    oInput.style.display = 'none'
    document.body.removeChild(oInput)
}
</script>
</html>