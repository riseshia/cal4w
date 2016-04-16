class Calendar extends React.Component {
  componentDidMount() {
    $.getJSON("/api/events/").success((data) => {
      $("#calendar").fullCalendar({
        header: {
          left: "prev,next today",
          center: "title",
          right: "month,agendaWeek,agendaDay",
        },
        events: data,
        timezone: "local",
        aspectRatio: 2.5,
      })
    })
  }
  render() {
    return (
      <div id="calendar"></div>
    )
  }
}
