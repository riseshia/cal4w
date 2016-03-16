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

  $(".quick-datetime-select").quickDatetimeSelector();
});

$.fn.quickDatetimeSelector = function(options) {

  var settings = $.extend({
    dateButtonClass: 'quick-datetime-select-date-button',
    weekButtonClass: 'quick-datetime-select-week-button',
    dayButtonClass: 'quick-datetime-select-day-button',
    buttonFormatter: button,
    template: null,
    onClickDateButton: clickDateButton,
    onClickWeekButton: clickWeekButton,
    onClickDayButton: clickDayButton,
    onChangeDate: changeDate,
    onChangeDay: displayDay,
    changeDateTrigger: fillDateFromParent
  }, options);

  settings.template = settings.template || template();

  function button(className, name, value, active) {
    active = active === false ? false : true;
    return '<button type="button" ' + (!active ? 'disabled ' : '') + 'value="' + value + '" class="' + className + ' btn btn-sm btn-default">' + name + '</button> ';
  }

  function dateButton(name, value, active) {
    return settings.buttonFormatter(settings.dateButtonClass, name, value, active);
  }

  function weekButton(name, value, active) {
    return settings.buttonFormatter(settings.weekButtonClass, name, value, active);
  }

  function dayButton(name, value, active) {
    return settings.buttonFormatter(settings.dayButtonClass, name, value, active);
  }

  function template() {
    return [
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
  }

  function clickDateButton() {
    var value = parseInt($(this).val());
    var $selector = $(this).prop('selector');

    if(!$selector) throw new Error('Selector Prop required');

    var date = new Date();
    date.setDate(date.getDate() + value);

    $selector.prop('date', date);
    $selector.prop('week', 0);
    $selector.trigger('change.date');
    $selector.trigger('change.day');
  }

  function clickWeekButton() {
    var value = parseInt($(this).val());
    var $selector = $(this).prop('selector');

    if(!$selector) throw new Error('Selector Prop required');

    $selector.prop('week', value);
    $selector.trigger('change.day');
  }

  function clickDayButton() {
    var day = parseInt($(this).val());
    var $selector = $(this).prop('selector');

    if(!$selector) throw new Error('Selector Prop required');

    var date = new Date();
    var week = parseInt($selector.prop('week'));

    var firstDayOfTheWeek = week * 7 + date.getDate() - date.getDay();
    date.setDate(firstDayOfTheWeek + day);

    $selector.prop('date', date);
    $selector.trigger('change.date');
  }

  function displayDay() {
    var $selector = $(this);
    var $buttons = $selector.find('.' + settings.dayButtonClass);
    var week = $selector.prop('week');
    $buttons.prop('disabled', week === null);

    if(week === 0) {
      var today = (new Date()).getDay();
      $buttons.each(function() {
        $(this).prop('disabled', parseInt($(this).val()) < today);
      });
    }
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

  function init(ele) {
    ele.each(function() {
      var $target = $(this);
      var $start = $($target.data('startDatetime'));
      var $end = $($target.data('endDatetime'));

      $target.html(settings.template);
      $target.on('change.date', settings.onChangeDate);
      $target.on('change.day', settings.onChangeDay);
      $target.find('button').prop('selector', $target);

      $target.on('click', '.' + settings.dateButtonClass, settings.onClickDateButton);
      $target.on('click', '.' + settings.weekButtonClass, settings.onClickWeekButton);
      $target.on('click', '.' + settings.dayButtonClass, settings.onClickDayButton);

      $target.prop('start', $start).prop('end', $end);
      $start.prop('parent', $target).on('change.date', settings.changeDateTrigger);
      $end.prop('parent', $target).on('change.date', settings.changeDateTrigger);
    });
  }

  init(this);
  return this;
};
