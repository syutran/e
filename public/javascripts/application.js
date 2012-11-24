// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// 渐变弹出层
$(document).ready(function(){

var objStr = "#UpLayer";
$(objStr).mouseover(function(){$(objStr + " ul").show();});
$(objStr).mouseout(function(){$(objStr + " ul").hide();});
});

