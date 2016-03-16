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

$(document).on('click', '.' + DATE_BUTTON_CLASS, function() {
  var value = parseInt($(this).val());
  var $selector = $(this).prop('selector');

  if(!$selector) throw new Error('Selector Prop required');

  var date = new Date();
  date.setDate(date.getDate() + value);

  $selector.prop('date', date);
  $selector.prop('week', null);
  $selector.trigger('change.date');
  $selector.trigger('change.day');
});

$(document).on('click', '.' + WEEK_BUTTON_CLASS, function() {
  var value = parseInt($(this).val());
  var $selector = $(this).prop('selector');

  if(!$selector) throw new Error('Selector Prop required');

  $selector.prop('week', value);
  $selector.trigger('change.day');
});

$(document).on('click', '.' + DAY_BUTTON_CLASS, function() {
  var day = parseInt($(this).val());
  var $selector = $(this).prop('selector');

  if(!$selector) throw new Error('Selector Prop required');

  var date = new Date();
  var week = parseInt($selector.prop('week'));

  var firstDayOfTheWeek = week * 7 + date.getDate() - date.getDay();
  date.setDate(firstDayOfTheWeek + day);

  $selector.prop('date', date);
  $selector.trigger('change.date');
});

function displayDay() {
  var $selector = $(this);
  var $buttons = $selector.find('.' + DAY_BUTTON_CLASS);
  $buttons.prop('disabled', $selector.prop('week') === null);
}

function changeDate() {
  $(this).prop('start').trigger('change.date');
  $(this).prop('end').trigger('change.date');
}

function fillDateFromParent() {
  var $selector = $(this);
  var $selects = $selector.find('select');
  var $parent = $(this).prop('parent');
  var date = $parent.prop('date');

  var values = [
    date.getFullYear(),
    date.getMonth() + 1,
    date.getDate()
  ];

  $selects.each(function(i) {
    if(values[i]) $(this).val(values[i]);
  });
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
      var $start = $($target.data('startDatetime'));
      var $end = $($target.data('endDatetime'));

      $target.html(template);
      $target.prop('start', $start).prop('end', $end);
      $target.on('change.date', changeDate);
      $target.on('change.day', displayDay);

      $start.prop('parent', $target).on('change.date', fillDateFromParent);
      $end.prop('parent', $target).on('change.date', fillDateFromParent);

      $target.find('button').prop('selector', $target).on('click', function() {

      });
    });
  }
}
