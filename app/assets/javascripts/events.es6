$(document).on("ready turbolinks:load", () => {
  if ($(".quick-datetime-select").length > 0) {
    $(".quick-datetime-select").quickDatetimeSelector({
      locale: {
        Today: "오늘",
        Tomorrow: "내일",
        ThisWeek: "이번 주",
        NextWeek: "다음 주",
        day: {
          Sunday: "일요일",
          Monday: "월요일",
          Tuesday: "화요일",
          Wednesday: "수요일",
          Thursday: "목요일",
          Friday: "금요일",
          Saturday: "토요일",
        },
      },
    })
  }

  if ($("#new_event_form").length) {
    // Setup current timezone
    const $timezone = $("#event_form_timezone_offset")
    const browserOffset = (new Date()).getTimezoneOffset()
    const offset = $timezone.find(`option[value=${browserOffset}]`).val()
    const defaultOffset = 540
    $timezone.val(offset)

    const getDate = () => {
      const year = Number($("#event_start_time_1i").val())
      const month = Number($("#event_start_time_2i").val())
      const day = Number($("#event_start_time_3i").val())
      const hour = Number($("#event_start_time_4i").val())
      const min = Number($("#event_start_time_5i").val())

      return new Date(year, month, day, hour, min)
    }

    const setDate = (date) => {
      let newMin = Math.floor(date.getMinutes() / 10) * 10
      if (newMin === 0) { newMin = "00" }
      let newHour = date.getHours()
      if (newHour < 10) { newHour = `0${newHour}` }

      $("#event_start_time_1i").val(date.getFullYear())
      $("#event_start_time_2i").val(date.getMonth())
      $("#event_start_time_3i").val(date.getDate())
      $("#event_start_time_4i").val(newHour)
      $("#event_start_time_5i").val(newMin)
    }

    const manipulateDate = (minOffset) => {
      const date = getDate()
      const min = date.getMinutes()

      date.setMinutes(min + minOffset)
      setDate(date)
    }

    // Transform UTC before submit
    $(".event-form").submit((event) => {
      manipulateDate(Number(offset) + defaultOffset)
      return true
    })
  }

  if ($(".summernote").length !== 0) {
    $(".summernote").summernote({ height: 300 })
  }
})
