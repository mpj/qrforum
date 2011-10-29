$("#mainform form").submit(function(event) {
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