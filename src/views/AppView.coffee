class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> 
      @model.get('playerHand').stand()
      console.log(@model.get('playerHand').scores()[0])
      console.log(@model.get('dealerHand').scores()[0])
      while @model.get('dealerHand').scores()[0] < 21
        @dealerMove()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  dealerMove: ->
    @model.get('dealerHand').at(0).set('revealed', true)
    @model.get('dealerHand').hit()

