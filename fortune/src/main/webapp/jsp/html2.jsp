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
	xmp {
	   display: inline-block;
	}
	* {
	   font-size: 20px;
	}
	</style>
</head>
<body style="padding: 10px;">
<div class="container w90">
    <br/>
    
    <div id='tags'></div>
    <br/>
    
    <div id='tagRender'> </div>
    <br/>
    
    <xmp></xmp>
    <br/>
    
    <div id='show'></div>
    
    <div style="display: none;">
        <select id='classSelect' multiple="multiple" style="height: 200px;">
            <option></option>
            <option value='container'>bootstrap.container</option>
            <option value='init'>div.init</option>
            <option value='w99h400'>textarea.w99h400</option>
            <option value='w99h200'>textarea.w99h200</option>
        </select>
        <select id='targetSelect'>
            <option></option>
            <option value='_blank'>_blank</option>
        </select>
    </div>
     
</div>
</body>
<script type="text/javascript">
var config = {
		'input':['id','width','class','style','placeholder'],
		'textarea':['id','width','height','class','style'],
		'radio':['label','name','value','width','height','style'],
		'checkbox':['label','name','value','width','height','style'],
		'a':['href','targetSelect','class'],
		'div':['class']
}
var cssArray = ['width','height'];
// 
for(var tagName in config) {
	$('#tags').append("<span class='lightgray' onclick='renderProps(\""+tagName+"\")'>"+tagName+"</span>");
}
function renderProps(tagName) {
	$("#tagRender,#show,xmp").empty();
	var props = config[tagName];
    var html = 
    	"  <table id='propTable' tagname='"+tagName+"'>\n" ;
    for(var i=0;i<props.length;i++) {
    	var propName = props[i]; 
    	html += " <tr><td class='w100'>"+propName+"</td><td>";
	    if(propName == 'class') {
	    	html += $("#classSelect").clone(false).attr('id','class')[0].outerHTML;
	    } else if(propName == 'targetSelect') {
	    	html += $("#targetSelect").clone(false).attr('id','target')[0].outerHTML;
	    } else {
	    	html += "<input id='"+propName+"'/>"; 
	    } 	
	    html += "</td></tr>\n";
    }
    html +=	"</table>\n" +
	$("#tagRender").append(html);
    $("#tagRender").find('input,select').bind('change',function(){
        $("#show").empty();
       	var tagName = $('#propTable').attr('tagname');
       	var $newTag;
       	if(tagName == 'radio' || tagName == 'checkbox') {
       		$newTag = $("<input type='"+tagName+"'>");
       	} else {
       		$newTag = $("<"+tagName+">");
       	}
       	$('#show').append($newTag);
       	$("#propTable input,#propTable select").each(function(){
       		var propName = $(this).attr('id');
       		if($.inArray(propName, cssArray) != -1) {
       			$newTag.css(propName,$(this).val());
       		} else if(propName == 'label') {
       			$newTag.after("<label class='mr10'>"+$(this).val()+"</label>");
       		} else if(propName.endsWith('Select')) {
       			$newTag.attr(propName.substr(0,propName.indexOf('Select')),$('#'+propName).val());
            } else {
        		$newTag.attr(propName,$(this).val());
       		}
       	})
       	$('xmp').text($('#show').html());
        copy($('#show').html());
    });
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