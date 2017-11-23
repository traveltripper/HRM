$(document).ready(function(){
$(".emp_link").click(function(){
    $('#employee_details').show();
});

var selector = '.teammembers_img';

$(selector).on('click', function(){
    $(selector).removeClass('active');
    $(this).addClass('active');
});

if ( $('.team_list li.active').length == 0 )
{
	$(".team_list li:first").addClass("active");
}


});