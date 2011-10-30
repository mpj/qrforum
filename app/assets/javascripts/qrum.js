

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