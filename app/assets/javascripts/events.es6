const getDate = () => {
  const year = Number($("#event_start_time_1i").val())
  const month = Number($("#event_start_time_2i").val()) - 1
  const day = Number($("#event_start_time_3i").val())
  const hour = Number($("#event_start_time_4i").val())
  const min = Number($("#event_start_time_5i").val())

  return new Date(year, month, day, hour, min)
}

const setDate = (date) => {
  let newMin = Math.ceil(date.getMinutes() / 10) * 10
  if (newMin === 0) { newMin = "00" }
  let newHour = date.getHours()
  if (newHour < 10) { newHour = `0${newHour}` }

  $("#event_start_time_1i").val(date.getFullYear())
  $("#event_start_time_2i").val(date.getMonth() + 1)
  $("#event_start_time_3i").val(date.getDate())
  $("#event_start_time_4i").val(newHour)
  $("#event_start_time_5i").val(newMin)
}

const convertToLocal = (offset) => {
  const date = getDate()
  const min = date.getMinutes()
  date.setMinutes(min - offset)
  setDate(date)
}

const convertToUTC = () => {
  const minOffset = Number($("#event_timezone_offset").val())
  const date = getDate()
  const min = date.getMinutes()

  date.setMinutes(min + minOffset)
  setDate(date)
}

const getLocalTzOffset = () => {
  if ($("#new_event").length) {
    const offset = (new Date()).getTimezoneOffset()
    $("#event_timezone_offset").val(offset)
    return offset
  }
  return Number($("#event_timezone_offset").val())
}

$(document).on("turbolinks:load", () => {
  if ($(".event-form").length) {
    // Transform UTC before submit
    $("input[type='submit']").click(event => {
      convertToUTC()
      return true
    })

    // Transform to local Time when loaded
    convertToLocal(getLocalTzOffset())
  }

  if ($(".summernote").length && !$(".note-editor").length) {
    $(".summernote").summernote({ height: 300 })
  }
})
