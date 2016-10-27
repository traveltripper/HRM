$(document).ready(function(){
$(".emp_link").click(function(){
    $('#employee_details').show();
});

var selector = '.teammembers_img';

$(selector).on('click', function(){
    $(selector).removeClass('active');
    $(this).addClass('active');
});

$(".team_list li:first").addClass("active");

});