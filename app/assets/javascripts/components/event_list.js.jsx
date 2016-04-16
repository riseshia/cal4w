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
  render() {
    var eventNodes = this.byEnable().map(function (event) {
      return (
        <Event key={event.id} startTime={event.start} subject={event.subject} place={event.place}/>
      )
    })
    return (
      <ul>{eventNodes}</ul>
    )
  }
}
