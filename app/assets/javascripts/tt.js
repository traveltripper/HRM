
$(document).on("click", "#custom-submit-link", function(){
   $("form#topbar-search").submit();
});



 $(function() {
   $("input[name='leaveStatus']").click(function() {
     if ($("#leave_status_approve").is(":checked")) {
       $("#reject_reason").hide();
     } else {
       $("#reject_reason").show();
     }
   });
 });

$(document).ready(function(){
  $('#new_employee input.btn.btn-primary.jsvalidation').click(function(e){

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

$(document).ready(function(){ 

  $('#employee_profile_picture').on('change', function() {
      $(".edit_employee").submit();
  });

  $(".upload_picture").click(function(){
        $('#employee_profile_picture').click();
        return false;
    }); 
});

// jQuery(function() {
//   var states;
//   //$('#person_state_id').parent().hide();
//   states = $('#employee_manager_id').html();
//   return $('#employee_department_id').change(function() {
//     var country, escaped_country, options;
//     country = $('#employee_department_id :selected').text();
//     escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
//     options = $(states).filter("optgroup[label='" + escaped_country + "']").html();
//     if (options) {
//       $('#employee_manager_id').html(options);
//       //return $('#person_state_id').parent().show();
//     } else {
//       $('#employee_manager_id').empty();
//       //return $('#person_state_id').parent().hide();
//     }
//   });
// });




  $(document).ready(function(){   

    $('.datepicker').datepicker({
    dateFormat: "dd-mm-yy",
    changeMonth: true,
    changeYear: true,
    yearRange: "1960:+3"
    });

    // $("#employee_department_id").change(function(){
    //   $("#employee_manager_id").empty();
    //   $.ajax({url: "/departments/" + encodeURIComponent($(this).attr('value')) + '/manager.json',
    //   success: function(result){
    //       if(result.employee_name != null ){
    //         var option = new Option(result.employee_name, result.employee_id);
    //         $("#employee_manager_id").append($(option));
    //         $("#notice-no-manager").css("display","none");
    //         if(result.employee_name == '' ){$("#notice-no-manager").css("display","inline");};
    //       };
          
          
    //       //$('.tag-tooltip').tooltip();
    //   },
    //   error: function(result){
    //       //$("#employee_manager_id").empty();
    //       //alert();
    //       //$('.tag-tooltip').tooltip();
    //   }
    //   });
    // });
    
  });


 $(function() {
   $("input[name='alert']").click(function() {
     if ($("#alert_particular").is(":checked")) {
       $("#emails_list").show(1000);
     } else {
       $("#emails_list").hide(1000);
     }
   });
 });


 jQuery(function() {
  var states;
  states = $('#payroll_employee_id').html();
  return $('#payroll_department').change(function() {
    var country, escaped_country, options;
    country = $('#payroll_department :selected').text();
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
    options = $(states).filter("optgroup[label='" + escaped_country + "']").html();
    if (options) {
      $('#payroll_employee_id').html(options);
    } else {
      $('#payroll_employee_id').empty();
    }
  });
});