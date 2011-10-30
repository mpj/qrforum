

$(".field.title textarea").select().focus();

$(document).ready(function() {
	if (navigator && navigator.userAgent) {
		var ua = navigator.userAgent.toLowerCase();
		var isIOs = ((ua.match(/iphone/i)) || 
					 (ua.match(/ipod/i)));
		var isAndroid = ua.match(/android/);

		if (isAndroid)
			$("#bookmark_bar #arrow").addClass('android');
		if (isIOs)
			$("#bookmark_bar #arrow").addClass('ios');
	}

	$(".field.signature input").val(getCookie('qrum_signature'));

	$("form.new_post").submit(function(event) {
		var body = $(".field.body textarea").val();
		var sig = $(".field.signature input").val();
		if (body.trim().length == 0) {
			event.preventDefault();
			alert("You must enter message body.")
		} else if (sig.trim().length == 0) {
			event.preventDefault();
			alert("You must enter a signature.")
		}
		setCookie('qrum_signature', sig, 120);
	});

	$("#follow_button").click(function(){
		var email = prompt("Enter your e-mail, and get new comments to your inbox:");
		if (email) {
			$.post($(this).attr('data-url'), { email: email, id: $(this).attr('data-id') });
			alert("Almost done! We have sent instructions on how to complete your subscription to " + email + ".");
		}
	});

	$(".field.title").limitMaxlength();
});


function setCookie(c_name,value,exdays)
{
  var exdate=new Date();
  exdate.setDate(exdate.getDate() + exdays);
  var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
  document.cookie=c_name + "=" + c_value;
}

function getCookie(c_name)
{
  var i,x,y,ARRcookies=document.cookie.split(";");
  for (i=0;i<ARRcookies.length;i++)
  {
    x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
    y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
    x=x.replace(/^\s+|\s+$/g,"");
    if (x==c_name) {
       return unescape(y);
    }
  }
}

jQuery.fn.limitMaxlength = function(options){

	var settings = jQuery.extend({
		attribute: "maxlength",
		onLimit: function(){},
		onEdit: function(){}
	}, options);

	// Event handler to limit the textarea
	var onEdit = function(){
		var textarea = jQuery(this);
		var maxlength = parseInt(textarea.attr(settings.attribute));

		if(textarea.val().length > maxlength){
			textarea.val(textarea.val().substr(0, maxlength));

			// Call the onlimit handler within the scope of the textarea
			jQuery.proxy(settings.onLimit, this)();
		}

		// Call the onEdit handler within the scope of the textarea
		jQuery.proxy(settings.onEdit, this)(maxlength - textarea.val().length);
	}

	this.each(onEdit);

	return this.keyup(onEdit)
				.keydown(onEdit)
				.focus(onEdit)
				.live('input paste', onEdit);
}