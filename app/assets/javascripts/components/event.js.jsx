class Event extends React.Component {
  render() {
    return (
      <li>
        {moment(this.props.startTime).format("MM/DD HH:mm")}~
        <a href="/events/{this.props.id}">{this.props.subject} in {this.props.place}</a>
        (참가: @shia)
      </li>
    )
  }
}
