<style type="text/css">
#title {
	width:432px;
	height:26px;
	color:#5A698B;
	font:bold 11px/18px "Lucida Grande", "Trebuchet MS", Arial, Helvetica, sans-serif;
	padding-top:5px;
	background:transparent url("/assets/img/bg_legend.gif") no-repeat;
	-moz-background-size:432px 29px; /* Firefox 3.6 */
	background-size:432px 29px;
	text-transform:uppercase;
	letter-spacing:2px;
	text-align:center;
}

form {
	width:435px;
	margin-top:40px;
	margin-left:auto;
	margin-right:auto;
}

.col1 {
	font:11px/24px "Lucida Grande", "Trebuchet MS", Arial, Helvetica, sans-serif;
	color:#5A698B;
	text-align:right;
	width:135px;
	height:31px;
	margin:0;
	float:left;
	margin-right:2px;
	background:url(/assets/img/bg_label.gif) no-repeat;
	-moz-background-size:135px 29px; /* Firefox 3.6 */
	background-size:135px 29px;
}

.col2 {
	font:11px/24px "Lucida Grande", "Trebuchet MS", Arial, Helvetica, sans-serif;
	color:#5A698B;
	width:295px;
	height:31px;
	display:block;
	float:left;
	margin:0;
	background:url(/assets/img/bg_textfield.gif) no-repeat;
	-moz-background-size:295px 29px; /* Firefox 3.6 */
	background-size:295px 29px;
}

.col2comment {
	font:11px/24px "Lucida Grande", "Trebuchet MS", Arial, Helvetica, sans-serif;
	color:#5A698B;
	width:295px;
	height:98px;
	margin:0;
	display:block;
	float:left;
	background:url(/assets/img/bg_textarea.gif) no-repeat;
	-moz-background-size:295px 96px; /* Firefox 3.6 */
	background-size:295px 96px;
}

.col1comment {
	font:11px/24px "Lucida Grande", "Trebuchet MS", Arial, Helvetica, sans-serif;
	color:#5A698B;
	text-align:right;
	width:135px;
	height:98px;
	float:left;
	display:block;
	margin-right:2px;
	background:url(/assets/img/bg_label_comment.gif) no-repeat;
}

div.row {
	font:11px/24px "Lucida Grande", "Trebuchet MS", Arial, Helvetica, sans-serif;
	color:#5A698B;
	clear:both;
	width:435px;
}

.submit {
	height:29px;
	width:432px;
	background:url(/assets/img/bg_submit.gif) no-repeat;
	-moz-background-size:432px 29px; /* Firefox 3.6 */
	background-size:432px 29px;
	padding-top:5px;
	clear:both;
} 

.input {
	background-color:#fff;
	font:11px/14px "Lucida Grande", "Trebuchet MS", Arial, Helvetica, sans-serif;
	color:#5A698B;
	margin:4px 0 5px 8px;
	padding:1px;
	border:1px solid #8595B2;
	width:274px;
}

.textarea {
	border:1px solid #8595B2;
	background-color:#fff;
	font:11px/14px "Lucida Grande", "Trebuchet MS", Arial, Helvetica, sans-serif;
	color:#5A698B;
	margin:4px 0 5px 8px;
	width:274px;
	height:84px;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	$("div#msg").hide();
	$("input#name").focus();

	$("input#submit").click(function() {
		try { spinner(true); } catch(e) { }
		$("label.col1").hide();
		$("span.col2").hide();
		$("div.submit").hide();
		$("label.col1comment").html("Status:&nbsp;&nbsp;");
		$("textarea#comment").hide();
		$("div#msg").show();
		$("div#msg").html("&nbsp;&nbsp;Submitting Registration...");

		var data = { method:'register', name:$("input#name").val(), fbname:$("input#fbname").val(), email:$("input#email").val(), telephone:$("input#telephone").val(), comment:$("textarea#comment").val() };

		$.ajax({
			type:'post',
			data:data,
			cache:false,
			url:'/com/Ajax/VisitorAjax.cfc',
			success: function(data,textStatus,httpRequest) {
				spinner(false);
				if(data.STATUS != "invalid") {
					$("div#msg").html($.evalJSON(data).CONTENT);
				} else {
					restorFrm();
				}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				$("div#msg").html(errorThrown);
//				$("div.submit").show();
				spinner(false);
			}
		});
		return(false);
	});
});

function restorFrm() {
	$("label.col1").show();
	$("span.col2").show();
	$("div.submit").show();
	$("label.col1comment").html("Comment:&nbsp;&nbsp;");
	$("div#msg").hide();
	$("textarea#comment").show();
	$("input#name").focus();
}
</script>

<form name="registration" id="registration" action="" method="post">
	<div id="title">Registration Form</div>
	<div class="row">
		<label class="col1">Full Name:&nbsp;&nbsp;</label>
		<span class="col2"><input name="name" class="input" type="text" id="name" tabindex="1" /></span>
	</div>
	<div class="row">
		<label class="col1">Facebook Name:&nbsp;&nbsp;</label>
		<span class="col2"><input name="fbname" class="input" type="text" id="fbname" tabindex="1" /></span>
	</div>
	<div class="row">
		<label class="col1">eMail Address:&nbsp;&nbsp;</label>
		<span class="col2"><input name="email" class="input" type="text" id="email" tabindex="2" /></span>
	</div>
	<div class="row">
		<label class="col1">Telephone:&nbsp;&nbsp;</label>
		<span class="col2"><input name="telephone" class="input" type="text" id="telephone" value="" tabindex="3" /></span>
	</div>
	<div class="row">
		<label class="col1comment">Comment:&nbsp;&nbsp;</label>
		<span class="col2comment"><div id="msg"></div><textarea class="textarea" rows="4" name="comment" id="comment" tabindex="4" ></textarea></span>
	</div>
	<div align="center" class="submit"><input id="submit" type="image" src="/assets/img/b_send.gif" alt="send" width="52" height="19" border="0" /></div>
</form>
