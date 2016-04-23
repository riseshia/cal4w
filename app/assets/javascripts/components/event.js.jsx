class Event extends React.Component {
  render() {
    const url = `/events/${this.props.id}`
    return (
      <li>
        {moment(this.props.startTime).format("MM/DD HH:mm")}~
        <a href={url}>{this.props.subject} in {this.props.place}</a>
        (참가: @shia)
      </li>
    )
  }
}
