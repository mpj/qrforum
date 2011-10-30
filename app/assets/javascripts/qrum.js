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
});

$(".field.title textarea").select().focus();

$(document).ready(function() {
	var ua = navigator.userAgent.toLowerCase();
	var isIOs = ((ua.match(/iphone/i)) || 
				 (ua.navigator.userAgent.match(/ipod/i)));
	var isAndroid = ua.match(/android/);

	if (isAndroid)
		$("#bookmark_bar #arrow").addClass('android');
	if (isIOs)
		$("#bookmark_bar #arrow").addClass('ios');
   	
});