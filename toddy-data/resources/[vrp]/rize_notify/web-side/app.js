$(document).ready(function(){
	window.addEventListener("message",function(event){ 
        var html = `<div class='message ${event.data.css}'><b>${event.data.prefix}</b> <p>${event.data.message}</p></div>`
		$(html).appendTo(".notification").show();

        let $el = $('.message');
        $el.addClass("received");
        setTimeout(() => {
            $el.removeClass("received");
            $el.fadeOut(800);
        },parseInt(event.data.delay));
	})
});