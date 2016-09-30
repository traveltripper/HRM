
$(document).on("click", "#custom-submit-link", function(){
   $("form#topbar-search").submit();
});



 $(function() {
   $("input[name='chkNo']").click(function() {
     if ($("#chkYes").is(":checked")) {
       $("#reject_reason").hide();
     } else {
       $("#reject_reason").show();
     }
   });
 });

$(document).ready(function(){
  $('input.btn.btn-primary').click(function(e){

    e.preventDefault();

    var allowedDomains = [ 'traveltripper.com'];
     var domain = $("#inputEmail").val().split("@")[1];
     if ($.inArray(domain, allowedDomains) !== -1) {
        $('form#new_employee').submit();
     } else{
        alert("Please enter a valid email address. example@traveltripper.com");
     }
    
  });
});