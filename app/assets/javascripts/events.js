$(document).on("ready page:load", function (event) {
  $("#calendar").fullCalendar({
    header: {
      left: "prev,next today",
      center: "title",
      right: "month,agendaWeek,agendaDay"
    },
    events: "/events/",
    timezone: "local",
    aspectRatio: 2.5
  })

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
        Saturday: "토요일"
      }
    }
  })

  if ($("#place").size() == 1) {
    var map;

    var placesSearchCB = function (status, data, pagination) {
      if (status === daum.maps.services.Status.OK) {
        if (data.places.length == 0) { return; }

        $("#mapPlaceholder").html('<div id="map" style="border:1px solid #000; width:500px; height:400px; margin:20px;"></div>');
        var mapContainer = document.getElementById('map'),
        mapOption = {
          center: new daum.maps.LatLng(37.566826, 126.9786567),
          level: 2
        };  
        map = new daum.maps.Map(mapContainer, mapOption); 
       
        var bounds = new daum.maps.LatLngBounds();
        for (var i=0; i<data.places.length; i++) {
          displayMarker(data.places[i]);    
          bounds.extend(new daum.maps.LatLng(data.places[i].latitude, data.places[i].longitude));
        }       
        map.setBounds(bounds);
      } 
    }

    var displayMarker = function (place) {
      var marker = new daum.maps.Marker({
        map: map,
        position: new daum.maps.LatLng(place.latitude, place.longitude) 
      }),
      infowindow = new daum.maps.InfoWindow({zIndex:1});

      daum.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.title + '</div>');
        infowindow.open(map, marker);
      });
    }
    new daum.maps.services.Places().keywordSearch($("#place").text(), placesSearchCB); 
  }
})
