class EventListPerDay extends React.Component {
  render() {
    let eventNodes = this.props.data.map((event) => {
      const key = "event-" + event.id
      return (
        <Event key={key} startTime={event.start} place={event.place} subject={event.subject} id={event.id} member_names={event.member_names} />
      )
    })
    return (
      <div className="per-day">{eventNodes}</div>
    )
  }
}
