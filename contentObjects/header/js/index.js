/* ContentObject:Header JS */
var reqArray = new Array();
var resArray = new Array();

$(document).ready(function() {
	curMenuItem = "mnuHome";

	$("li#" + curMenuItem).addClass("current");
	doMenu(curMenuItem);

	$("li.mnuItem").click(function() {
		try { spinner(true); } catch(e) { }
		$("div.contentRoot").html("");
		$("li#" + curMenuItem).removeClass("current");
		curMenuItem = $(this).attr("id");
		$("li#" + curMenuItem).addClass("current");
		doMenu($(this).attr("id"));
		return(false);
	});

});

function doMenu(mnuItem) {
	var hashLink = $(document).attr("URL").split("#");
	if(hashLink.length === 2) {
		mnuItem = "cop" + hashLink[1];
	} 
	var data = { method:'dispatch',command:mnuItem };
	$.ajax({
		type:'post',
		data:data,
		cache:false,
		url:'/com/Ajax/VisitorAjax.cfc',
		success: function(data,textStatus,httpRequest) {
			$("div.contentRoot").html($.evalJSON(data).CONTENT);
			spinner(false);
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { }
	});
}

