class Calendar extends React.Component {
  componentWillReceiveProps(nextProps) {
    $("#calendar").fullCalendar({
      header: {
        left: "prev,next today",
        center: "title",
        right: "month,agendaWeek,agendaDay",
      },
      events: "/api/events/",
      timezone: "local",
      aspectRatio: 2.5,
    })
  }

  render() {
    return (
      <div className="row">
        <div className="col-xs-12">
          <div id="calendar"></div>
        </div>
      </div>
    )
  }
}
