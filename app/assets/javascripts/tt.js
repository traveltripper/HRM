
var selector = '#side-menu li';

$(selector).on('click', function(){
	alert();
    $(selector).removeClass('active');

    $(this).addClass('active');
});

$(document).ready(function(){
    $(".nav > ul > li").click(function () {
          $(this).siblings().removeClass("active");
          $(this).addClass("active");
    });
})