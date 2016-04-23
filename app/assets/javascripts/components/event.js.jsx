class Event extends React.Component {
  render() {
    const url = `/events/${this.props.id}`
    const member_names = this.props.member_names.join(", ")
    return (
      <li>
        {moment(this.props.startTime).format("MM/DD HH:mm")}~
        <a href={url}>{this.props.subject} in {this.props.place}</a>
        (참가: {member_names})
      </li>
    )
  }
}
