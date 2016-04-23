class EventList extends React.Component {
  constructor(props) {
    super(props)
    this.state = { data: [] }
  }
  componentDidMount() {
    $.getJSON("/api/events/").success((data) => {
      this.setState({ data: data })
    }.bind(this))
  }
  byEnable() {
    return this.state.data.filter((event) => {
      return moment(event.end) > moment()
    })
  }
  perDay() {
    if (this.state.data.length === 0) {
      return []
    }
    const enableEvent = this.byEnable()
    let list = []
    let day = { list: [], key: null }
    let currentDate
    enableEvent.forEach((event) => {
      const eventDate = moment(event.start).format("MM-DD")
      currentDate = currentDate || eventDate
      if (eventDate !== currentDate) {
        list.push(day)
        day = { list: [] }
        currentDate = eventDate
      }
      day.key = currentDate
      day.list.push(event)
    }, this)
    list.push(day)
    return list
  }
  render() {
    const eventlistNodes = this.perDay().map((events) => {
      return (
        <EventListPerDay key={events.key} data={events.list} />
      )
    })
    return (
      <div>
        <div className="row">
          <div className="col-xs-12">
            <h2>Next Events</h2>
          </div>
        </div>
        <div className="row">
          <div className="col-xs-12">
            <ul>{eventlistNodes}</ul>
          </div>
        </div>
      </div>
    )
  }
}
