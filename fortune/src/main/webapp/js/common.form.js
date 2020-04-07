var CommonForm = {};
//获得值
CommonForm.getJson = function(selector){
	var returnJson = {};
	var $panel = $(selector);
	var eles = $panel.find(".easyui-validatebox,.easyui-numberbox,input,select,:hidden,textarea");
	$.each(eles, function(i, uiComponent) {
		returnJson[$(uiComponent).attr('name')] = $(uiComponent).val();
	});	
	$.each($panel.find(".easyui-textbox"), function(i, uiComponent) {
		returnJson[$(uiComponent).attr('name')] = $(uiComponent).textbox('getValue');
	});	
	$.each($panel.find(".easyui-datetimebox"), function(i, uiComponent) {
		returnJson[$(uiComponent).attr('name')] = $(uiComponent).datebox('getValue');
	});	
	$.each($panel.find(".easyui-combobox"), function(i, uiComponent) {
		returnJson[$(uiComponent).attr('name')] = $(uiComponent).combobox('getValue');
	});	
	delete returnJson['undefined'];
	return returnJson;
}
// 设置值
CommonForm.setJson = function(selector, jsonObj) {
	var $panel = $(selector);
	$.each($panel.find(".easyui-validatebox,.easyui-numberbox,input,select,input:hidden"), function(i, uiComponent) {
		$(uiComponent).val(jsonObj[$(uiComponent).attr('name')]);
	});
	$.each($panel.find("textarea"), function(i, uiComponent) {
		$(uiComponent).text(jsonObj[$(uiComponent).attr('name')]);
	});
	$.each($panel.find(".easyui-textbox"), function(i, uiComponent) {
		$(uiComponent).textbox('setValue',jsonObj[$(uiComponent).attr('name')]);
	});	
	$.each($panel.find("input:checkbox"), function(i, uiComponent) {
		var val = jsonObj[$(uiComponent).attr('name')];
		if(val == 1) {
			$(uiComponent).attr('checked',true);
		}
	});		
}
// 重置表单的值
CommonForm.resetForm = function(selector) {
	var $panel = $(selector);
	$.each($panel.find(".easyui-validatebox,.easyui-numberbox,input"), function(i, uiComponent) {
		$(uiComponent).val('');
	});	
}

// 给对象的每个属性添加前缀
function patchPrefix(obj,prefix) {
	for(var key in obj) {
		obj[prefix+key] = obj[key];
	}
	return obj;
}
