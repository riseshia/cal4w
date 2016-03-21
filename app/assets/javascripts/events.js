$(document).on('ready page:load', function (event) {
  $('#calendar').fullCalendar({
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    events: '/events/',
    timezone: 'local',
    aspectRatio: 2.5
  });

  $(".quick-datetime-select").quickDatetimeSelector({
    locale: {
      Today: '오늘',
      Tomorrow: '내일',
      ThisWeek: '이번 주',
      NextWeek: '다음 주',
      day: {
        Sunday: '일요일',
        Monday: '월요일',
        Tuesday: '화요일',
        Wednesday: '수요일',
        Thursday: '목요일',
        Friday: '금요일',
        Saturday: '토요일'
      }
    }
  });
});
