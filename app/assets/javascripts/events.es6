$(document).on("ready page:load", () => {
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

  if ($("#event_timezone").length === 1) {
    // Setup current timezone
    const $timezone = $("#event_timezone")
    const browserOffset = (new Date()).getTimezoneOffset()
    const offset = $timezone.find(`option[value=${browserOffset}]`).val()
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
      let new_min = Math.floor(date.getMinutes() / 10) * 10
      if (new_min == 0) { new_min = "00" }

      $("#event_start_time_1i").val(date.getFullYear())
      $("#event_start_time_2i").val(date.getMonth())
      $("#event_start_time_3i").val(date.getDate())
      $("#event_start_time_4i").val(date.getHours())
      $("#event_start_time_5i").val(new_min)
    }

    const manipulateDate = (minOffset) => {
      let date = getDate()
      const min = date.getMinutes()

      date.setMinutes(min + minOffset)
      setDate(date)
    }

    if ($("#update-submit").length === 1) {
      manipulateDate(- Number(offset) - 540)
    }

    // Transform UTC before submit
    $(".event-form").submit(function (event) {
      manipulateDate(Number(offset) + 540)
      return true
    })
  }

  if ($("#place").length === 1) {
    let map

    const displayMarker = (place) => {
      const marker = new daum.maps.Marker({
        map,
        position: new daum.maps.LatLng(place.latitude, place.longitude),
      })
      const infowindow = new daum.maps.InfoWindow({ zIndex: 1 })

      daum.maps.event.addListener(marker, "click", () => {
        infowindow.setContent(`<div style='padding:5px;font-size:12px;'>${place.title}</div>`)
        infowindow.open(map, marker)
      })
    }

    const placesSearchCB = (status, data) => {
      if (status === daum.maps.services.Status.ZERO_RESULT) {
        $("#mapPlaceholder").html("<br>키워드를 통해서 장소를 찾을 수 없습니다.<br><br>")
      } else if (status === daum.maps.services.Status.OK) {
        if (data.places.length > 1) {
          $("#mapPlaceholder").html("<br>키워드를 통해서 검색되는 장소가 2개 이상이므로 지도를 생략합니다.<br><br>")
          return
        }

        $("#mapPlaceholder").html("<div id='map' class='map'></div>")
        const mapContainer = document.getElementById("map")
        const mapOption = {
          center: new daum.maps.LatLng(37.566826, 126.9786567),
          level: 2,
        }
        map = new daum.maps.Map(mapContainer, mapOption)

        const bounds = new daum.maps.LatLngBounds()
        for (let i = 0; i < data.places.length; i++) {
          displayMarker(data.places[i])
          bounds.extend(new daum.maps.LatLng(data.places[i].latitude, data.places[i].longitude))
        }
        map.setBounds(bounds)
      }
    }

    new daum.maps.services.Places().keywordSearch($("#place").text(), placesSearchCB)
  }

  if ($(".summernote").length !== 0) {
    $(".summernote").summernote({ height: 300 })
  }
})
