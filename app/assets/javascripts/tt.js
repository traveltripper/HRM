
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


