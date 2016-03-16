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
    activeDayClass: 'btn-success',
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
        '</div>',
        '<div class="quick-datetime-selector-week">',
          weekButton('This Week', 0),
          weekButton('Next Week', 1),
        '</div>',
        '<div class="quick-datetime-selector-day">',
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
    var week = 0;
    date.setDate(date.getDate() + value);

    $selector.prop('date', date);
    $selector.prop('selectedDay', date.getDay());
    $selector.prop('week', week);
    $selector.prop('selectedWeek', week);
    $selector.trigger('quickdatetime:change:date');
    $selector.trigger('quickdatetime:change:day');
  }

  function clickWeekButton() {
    var value = parseInt($(this).val());
    var $selector = $(this).prop('selector');

    if(!$selector) throw new Error('Selector Prop required');

    $selector.prop('week', value);
    $selector.trigger('quickdatetime:change:day');
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
    $selector.prop('selectedWeek', week);
    $selector.prop('selectedDay', day);
    $selector.trigger('quickdatetime:change:date');
    $selector.trigger('quickdatetime:change:day');
  }

  function displayDay() {
    var $selector = $(this);
    var $buttons = $selector.find('.' + settings.dayButtonClass);

    var week = $selector.prop('week');
    var date = $selector.prop('date');
    var currentDate = new Date();

    var selectedWeek = $selector.prop('selectedWeek');
    var selectedDay = $selector.prop('selectedDay');

    $buttons.prop('disabled', week === null);

    if(week === 0) {
      var today = currentDate.getDay();
      $buttons.each(function() {
        $(this).prop('disabled', parseInt($(this).val()) < today);
      });
    }

    $buttons.removeClass(settings.activeDayClass);

    if(week === selectedWeek) {
      $buttons.each(function() {
        if($(this).val() == selectedDay) {
          $(this).addClass(settings.activeDayClass);
          return false;
        }
      })
    }
  }

  function changeDate() {
    $(this).prop('start').trigger('quickdatetime:change:date');
    $(this).prop('end').trigger('quickdatetime:change:date');
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

  function getYMDDate(date) {
    return [
      date.getFullYear(),
      date.getMonth() + 1,
      date.getDate()
    ].join("/");
  }

  function init(ele) {
    ele.each(function() {
      var $target = $(this);
      var $start = $($target.data('startDatetime'));
      var $end = $($target.data('endDatetime'));

      $target.html(settings.template);
      $target.on('quickdatetime:change:date', settings.onChangeDate);
      $target.on('quickdatetime:change:day', settings.onChangeDay);
      $target.find('button').prop('selector', $target);

      $target.on('click', '.' + settings.dateButtonClass, settings.onClickDateButton);
      $target.on('click', '.' + settings.weekButtonClass, settings.onClickWeekButton);
      $target.on('click', '.' + settings.dayButtonClass, settings.onClickDayButton);

      $target.prop('start', $start).prop('end', $end);
      $start.prop('parent', $target).on('quickdatetime:change:date', settings.changeDateTrigger);
      $end.prop('parent', $target).on('quickdatetime:change:date', settings.changeDateTrigger);

      $target.prop('date', new Date());
      $target.prop('week', 0);
      $target.trigger('quickdatetime:change:date');
      $target.trigger('quickdatetime:change:day');
    });
  }

  init(this);
  return this;
};
