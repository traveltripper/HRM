// $(function(){ // DOM ready

//   // ::: TAGS BOX
//   var list = [];
//   $("#enter_emails").on({

//     focusout : function() {
//       var txt = this.value.replace(/[^a-z0-9\+\-\@\.\#]/ig,''); // allowed characters   

//           if(txt) 
//           {           
//               if(validateEmail(txt)){
//                 $('.email-errors').hide();
//                 $("<span/>", {text:txt, insertBefore:this});
//                 this.value = "";
//                 list.push(txt);
//                 $('textarea#get_email').val(list);
//               }
//               else{
//                   this.value = "";
//                   $('.email-errors').show();
//               };                  
            
//           };                
//     },

//     keyup : function(ev) {
//       // if: comma|enter (delimit more keyCodes with | pipe)
//       if(/(188|13)/.test(ev.which)) $(this).focusout();     

//     }
//   });

//   $('#emails_list').on('click', 'span', function() {
//     //if(confirm("Remove "+ $(this).text() +"?")) 
//       $(this).remove();
//       var removeItem = $(this).text();
//       list = jQuery.grep(list, function(value) {
//         return value != removeItem;
//       }); 
//       $('textarea#get_email').val(list); 
//   });


//   function validateEmail($email) {
//   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;  
//   return emailReg.test( $email );
//   };
      
// });