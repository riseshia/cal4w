class EventIndex extends React.Component {
  constructor(props) {
    super(props)
    this.state = { data: [] }
  }

  componentDidMount() {
    $.getJSON("/api/events/").success((data) => {
      this.setState({data: data})
    }.bind(this))
  }
  render() {
    return (
      <div>
        <Calendar data={this.state.data} />
        <EventList data={this.state.data} />
        <div className="row">
          <div className="col-xs-12">
            <a className="btn btn-primary new-event" href="/events/new">New Event</a>
          </div>
        </div>
      </div>
    )
  }
}
