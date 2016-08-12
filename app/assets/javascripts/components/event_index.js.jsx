class EventIndex extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      data: [],
      isLoaded: false
    }
  }

  componentDidMount() {
    const today = moment()
    const todayStr = today.format("YYYY-MM-DD")
    $.getJSON("/api/events/", {start: todayStr, _: +today}).success((data) => {
      this.setState({data: data, isLoaded: true})
    }.bind(this))
  }

  renderLoadMessage() {
    return (
      <div>
        <p>이벤트 정보를 불러오고 있습니다.</p>
      </div>
    )
  }

  render() {
    if (!this.state.isLoaded) {
      return this.renderLoadMessage();
    }
    return (
      <div>
        <Calendar data={this.state.data} />
        <EventList data={this.state.data} />
      </div>
    )
  }
}
