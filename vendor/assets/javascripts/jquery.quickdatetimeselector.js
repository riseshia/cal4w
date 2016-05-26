$.fn.quickDatetimeSelector = function(options) {

  var settings = $.extend({
    dateButtonClass: 'quick-datetime-select-date-button',
    weekButtonClass: 'quick-datetime-select-week-button',
    dayButtonClass: 'quick-datetime-select-day-button',
    activeWeekClass: 'btn-info',
    activeDayClass: 'btn-success',
    buttonFormatter: button,
    template: null,
    onClickDateButton: clickDateButton,
    onClickWeekButton: clickWeekButton,
    onClickDayButton: clickDayButton,
    onChangeDate: changeDate,
    onChangeDay: displayDay,
    changeDateTrigger: fillDateFromParent,
    locale: {
      Today: 'Today',
      Tomorrow: 'Tomorrow',
      ThisWeek: 'This Week',
      NextWeek: 'Next Week',
      day: {
        Sunday: 'Sunday',
        Monday: 'Monday',
        Tuesday: 'Tuesday',
        Wednesday: 'Wednesday',
        Thursday: 'Thursday',
        Friday: 'Friday',
        Saturday: 'Saturday'
      }
    }
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
    var locale = settings.locale;
    var days = locale.day;
    return [
      '<div class="quick-datetime-selector">',
        '<div class="quick-datetime-selector-term">',
          dateButton(locale.Today, 0),
          dateButton(locale.Tomorrow, 1),
        '</div>',
        '<div class="quick-datetime-selector-week">',
          weekButton(locale.ThisWeek, 0),
          weekButton(locale.NextWeek, 1),
        '</div>',
        '<div class="quick-datetime-selector-day">',
          dayButton(days.Sunday, 0, false),
          dayButton(days.Monday, 1, false),
          dayButton(days.Tuesday, 2, false),
          dayButton(days.Wednesday, 3, false),
          dayButton(days.Thursday, 4, false),
          dayButton(days.Friday, 5, false),
          dayButton(days.Saturday, 6, false),
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
    var $weekButtons = $selector.find('.' + settings.weekButtonClass);

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
      });
    }

    $weekButtons.removeClass(settings.activeWeekClass);

    if(week === selectedWeek) {
      $weekButtons.each(function() {
        if($(this).val() == selectedWeek) {
          $(this).addClass(settings.activeWeekClass);
          return false;
        }
      });
    }
  }

  function changeDate() {
    $(this).prop('start').trigger('quickdatetime:change:date');
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

  function changeDateManually() {
    var $selector = $(this);
    var $selects = $selector.find('select');
    var $parent = $(this).prop('parent');
    $parent.find('.' + settings.activeDayClass).removeClass(settings.activeDayClass);
  }

  function init(ele) {
    ele.each(function() {
      var $target = $(this);
      var $start = $($target.data('startDatetime'));
      var today = new Date();
      var thisWeek = 0;

      $target.html(settings.template);
      $target.on('quickdatetime:change:date', settings.onChangeDate);
      $target.on('quickdatetime:change:day', settings.onChangeDay);
      $target.find('button').prop('selector', $target);

      $target.on('click', '.' + settings.dateButtonClass, settings.onClickDateButton);
      $target.on('click', '.' + settings.weekButtonClass, settings.onClickWeekButton);
      $target.on('click', '.' + settings.dayButtonClass, settings.onClickDayButton);

      $target.prop('start', $start);
      $start.prop('parent', $target).on('quickdatetime:change:date', settings.changeDateTrigger);

      $start.on('change.quickdatetime', changeDateManually);

      $target.prop('date', today);
      $target.prop('week', thisWeek);
      $target.prop('selectedDay', today.getDay());
      $target.prop('selectedWeek', thisWeek);

      $target.trigger('quickdatetime:change:date');
      $target.trigger('quickdatetime:change:day');
    });
  }

  init(this);
  return this;
};
