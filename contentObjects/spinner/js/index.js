/* ContentObject:spinner JS */

$(document).ready(function() {
	spinX = Math.floor($("div.mainBody").position().left + Math.floor(parseInt($("div.mainBody").css("width"))/2));
	spinY = Math.floor($("div.mainBody").position().top + Math.floor(parseInt($("div.mainBody").css("height"))/2));
});

function spinner(state) {
	if(!state) $("div.spinner").hide();
	$("div.spinner").css("top",spinY+"px");
	$("div.spinner").css("left",spinX+"px");
	if(state && ($("div.spinner").css("display") === "none")) $("div.spinner").show();
}