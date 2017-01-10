class EventShow extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      title: "",
      place: "",
      owener: "",
      description: "",
      start_time: "",
      joiner_names: []
    }
  }

  componentDidMount() {
    $.getJSON(`/api/events/${this.props.id}`).success(data => {
      this.setState({...data})
    })
  }

  renderJoinerNames() {
    if (!this.state.joiner_names.length) {
      return null
    }

    return (
      <div>
        <h2>누가 방문하나요?</h2>
        <dl>
          <dt>방문자:</dt>
          <dd>{ this.state.joiner_names.join(", ") }</dd>
        </dl>
      </div>
    )
  }

  render() {
    return (
      <div className="row">
        <div className="col-xs-12">
          <h1>{ this.state.title }</h1>
          <dl>
            <dt>장소:</dt>
            <dd>{ this.state.place }</dd>
            <dt>소개:</dt>
            <dd dangerouslySetInnerHTML={{__html: this.state.description}}></dd>
            <dt>주최자:</dt>
            <dd>{ this.state.owner }</dd>
            <dt>모임시간</dt>
            <dd>{ moment(this.state.start_time).format("MM/DD HH:mm") } ~ { moment(this.state.finish_time).format("MM/DD HH:mm Z") }</dd>
          </dl>
          { this.renderJoinerNames() }
        </div>
      </div>  
    )
  }
}
