class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>_of_<%= suitName %>.png" height="140" width="100">'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.html '<img src="img/card-back.png" height="140" width="100">' unless @model.get 'revealed'
