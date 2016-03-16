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

  quickDatetimeSelector(".quick-datetime-select");
});

var DATE_BUTTON_CLASS = 'quick-datetime-select-date-button';
var WEEK_BUTTON_CLASS = 'quick-datetime-select-week-button';
var DAY_BUTTON_CLASS = 'quick-datetime-select-day-button';

function button(className, name, value, active) {
  active = active === false ? false : true;
  return '<button type="button" ' + (!active ? 'disabled ' : '') + 'value="' + value + '" class="' + className + ' btn btn-sm btn-default">' + name + '</button> ';
}

function dateButton(name, value, active) {
  return button(DATE_BUTTON_CLASS, name, value, active);
}

function weekButton(name, value, active) {
  return button(WEEK_BUTTON_CLASS, name, value, active);
}

function dayButton(name, value, active) {
  return button(DAY_BUTTON_CLASS, name, value, active);
}

function quickDatetimeSelector(target) {

  var template = [
    '<div class="quick-datetime-selector">',
      '<div class="quick-datetime-selector-term">',
        dateButton('Today', 0),
        dateButton('Tomorrow', 1),
        weekButton('This Week', 0),
        weekButton('Next Week', 1),
      '</div>',
      '<div class="quick-datetime-selector-week">',
        dayButton('Sunday', 0, false),
        dayButton('Monday', 1, false),
        dayButton('Tuesday', 2, false),
        dayButton('Wednesday', 3, false),
        dayButton('Thursday', 4, false),
        dayButton('Friday', 5, false),
        dayButton('Saturday', 6, false),
      '</div>',
    '</div>',
  ].join("");

  if($(target).length > 0) {
    $(target).each(function() {
      var $target = $(this);
      $target.html(template);
    })
  }
}
