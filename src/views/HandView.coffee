class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score" id="<% if(isDealer){ %>dealerscore<% }else{ %>playerscore<% } %>"></span>)</h2>'

  initialize: ->
  
    @collection.on 'add remove change', => 
      @render()
      @collection.checkscore()

    @render()
    @collection.checkscore()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.getScore();