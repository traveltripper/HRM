var initialize_calendar;
initialize_calendar = function() {
  $('.calendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title'
      },
      aspectRatio: 1.8,
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      timeFormat: 'HH:mm' ,
      //eventColor: '#3A6F9F',
      //events: '/events.json',
      eventSources: [
      {
        url: '/events.json'
      },
      {
        url: '/birthdays.json',
        imageurl:'/images/birthdayicon.jpg'
      }
      ],

            
      select: function(start, end) {
        $.get('/get_current_employee_role', function(result){
          if (result.role == "HR")
          {
            $.getScript('/events/new', function() {
            $('#event_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
          date_range_picker();
            $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
            $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
            });
          }
        });
        

        calendar.fullCalendar('unselect');
      },

      eventRender: function(event, eventElement) {
        //alert();
    if (event.type == "birthday") {
        
        eventElement.find("div.fc-content").prepend("<img src='images/birthdayicon.jpg' width='35' height='30'>");
        eventElement.find("a.fc-event").css('border', 'red');
    }else
    {
      eventElement.find("div.fc-content").prepend("<img src='images/cal.jpg' width='35' height='30'>");
    }
    },

      eventDrop: function(event, delta, revertFunc) {
        $.get('/get_current_employee_role', function(result){
          if (result.role == "HR")
          {
            event_data = { 
              event: {
                id: event.id,
                start: event.start.format(),
                end: event.end.format()
              }
            };
            $.ajax({
                url: event.update_url,
                data: event_data,
                type: 'PATCH'
            });
          }
        });
      },
      
      eventClick: function(event, jsEvent, view) {
        
        if (event.type == "birthday")
        {
            $('#modalTitle').html("Happy Birthday!!!");
            $('#modalBody .cal-name').html(event.fullname);
            $('#modalBody .cal-dept').html(event.department);
            $('#modalBody .cal-role').html(event.role);
            $('#calendarModal').modal();
        } 
        else if (event.type == "event") 
        {
          
          $.get('/get_current_employee_role', function(result){
            if (result.role == "HR"){
                  //$('#calendarModal').modal();
                $.getScript(event.edit_url, function() {
                  $('#event_date_range').val(moment(event.start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(event.end).format("MM/DD/YYYY HH:mm"))
                 date_range_picker();
                  $('.start_hidden').val(moment(event.start).format('YYYY-MM-DD HH:mm'));
                  $('.end_hidden').val(moment(event.end).format('YYYY-MM-DD HH:mm'));
                });
            } 
            else
            {
                //start = event.start.toString();
                
                $('#EventModal #modalTitle').html("Event!!!");
                $('#EventModal #modalBody .event-title').html(event.title);
                $('#EventModal #modalBody .event-from').html(event.start.toString().substr(0, 25));
                $('#EventModal #modalBody .event-to').html(event.end.toString().substr(0, 25));
                $('#EventModal').modal();
            }
          });     
        } 
      }
    });
  })
};


