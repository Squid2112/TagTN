/* views:Main JS */

var spinX = 0;
var spinY = 0;
var reqArray = new Array();
var resArray = new Array();

$(document).ready(function() {
	$("div.#mainBody").height($("div.innerMain").height()-58);
	$(window).bind("resize", resizeWindow);

	$.doTimeout("pingTimer", 300000, function() {
		var data = { method:'ping' };
		$.ajax({
			type:'post',
			data:data,
			cache:false,
			url:'/com/Ajax/VisitorAjax.cfc',
			success: function(data,textStatus,httpRequest) {
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) { }
		});
		return(true);
	});
});

function resizeWindow(e) {
	$("div.#mainBody").height($("div.innerMain").height()-58);
	spinX = Math.floor($("div.mainBody").position().left + Math.floor(parseInt($("div.mainBody").css("width"))/2));
	spinY = Math.floor($("div.mainBody").position().top + Math.floor(parseInt($("div.mainBody").css("height"))/2));
	try {
		spinner($("div.spinner").css("display") !== "none");
	} catch(e) { }
}