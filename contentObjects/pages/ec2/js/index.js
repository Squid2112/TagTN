alert("foo");

$(document).ready(function() {
	 var bm =  "url(http://app.talkfusion.com/eform/154.png)";
	 var bf =  "url(http://app.talkfusion.com/)"; 
	 var bp =  "right bottom";
	 var w = "360px";
	 var h = "508px";
	 var imgh = 0;
	 $("#container").css("width", w);
	 $("#container").css("height", h);
	//var fh = 508 - imgh;
	//var fht = fh + "px";
	var fh = 508; 
	var fht = fh + "px";
	$("#form-builder").css("width", w);
	$("#form-builder").css("height", fht);
	$("#form-builder").css("color", "#000000");
	$("#form-builder").css("font-size", "16px");
	$("#form-builder").css("background-color", "#0091ff");
	$("#form-builder").css("background-image", bm);
	$("#form-builder").css("background-repeat", "no-repeat");
	$("#form-builder").css("background-position", bp);
	$("#form-title h2").css("color", "#050505");
	$("#form-title h2").css("font-size", "24px");	 
	$(".f_100").css("margin-left", "20px");
});


$("#submitBtn").click(function () {
    var valid = true;
    $("#form-preview").find("span.needsfilled").remove();
    $("#form-preview").find('span.error-message').hide();
    $("#form-preview").find('.req').each(function () {
        if ($(this).val() == "") {
            $(this).parent().find("*").append('<span class="needsfilled">This field is required.</span>');
            valid = false;
        } else if ($(this).hasClass('req-email') && !checkemail($(this).val())) {
            $(this).parent().find("*").append('<span class="needsfilled">This email is invalid.</span>');
            $(this).val('');
            valid = false;
        } else if ($(this).hasClass('req-num') && validatePhone($(this).val()) != '') {
            $(this).parent().find("*").append('<span class="needsfilled">This phone number is invalid.</span>');
            valid = false;
        }
    });

    //find checkbox groups and iterate through them
    $("#form-preview").find('.checkbox-container, .radio-container').each(function () {
        thisGroup = $(this).children('label').attr('for');
        controlLabel = $(this).children('label').html();
        //if control has required indicator in label do the validation check
        if (controlLabel.indexOf('*') != -1) {
            checkCount = ($('input[name="' + thisGroup + '"]:checked').length)
            if (checkCount == 0) {
                $(this).find('label').append('<span class="needsfilled">You must make a selection.</span>');
                valid = false;
            }
        }
    });
    //find the captcha
    $("#form-preview").find('.captcha-container').each(function () {
        controlLabel = $(this).find('label').html();
        textFieldVal = $(this).find('input').val();
        //if control has required indicator in label do the validation check
        if (controlLabel.indexOf('*') != -1) {
            if (textFieldVal == "") {
                $(this).find('img').parent().after('<div style="width: 100px; float: left;"><span class="needsfilled">You must reproduce the characters.</span></div>');
                valid = false;
            }
        }
    });
    $("#form-preview").find("select").each(function () {
        controlLabel = $(this).siblings('label');
        if (controlLabel.html().indexOf('*') != -1 && $(this).val() == "") {
            controlLabel.append('<span class="needsfilled">You must make a selection.</span>');
        }
    });
    $("#form-preview textarea").each(function () {
        if ($(this).val().length > 1000) {
            var Msg = "Label Length Should Less Than 1000 characters";
            $(this).parent().find("*").append('<span class="needsfilled">Textarea Should Less Than 1000 characters!</span>');
            valid = false;
        }
    });
    if (!valid) {
        $(this).find('span.error-message').text("Please correct the above errors.").show();
        return false;
    } else {
        $("#form-preview").submit();
    }
});



function checkemail(e){
var emailfilter = /^\w+[\+\.\w-]*@([\w-]+\.)*\w+[\w-]*\.([a-z]{2,4}|\d+)$/i
return emailfilter.test(e);
}

function checknum(e) {
var filter = /^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$/
return filter.test(e);
}

function validatePhone(phone) {
var error = "";
var stripped = phone.replace(/[\(\)\.\-\ ]/g, '');     
if (stripped == "" || isNaN(stripped)) {
error = "Please verify your phone number.";
} 
return error;
}