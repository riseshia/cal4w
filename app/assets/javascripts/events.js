$(document).on('ready page:load', function (event) {
  $('#calendar').fullCalendar({
    events: '/events/'
  });
});
