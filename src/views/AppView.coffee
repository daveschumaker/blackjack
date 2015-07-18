class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="new-game">New Game</button> 
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> 
      while @model.get('dealerHand').dealerScore() < 17
        @model.get('dealerHand').dealerMove()

    'click .new-game': -> @resetHands()


  initialize: ->
    @model.get('playerHand').on 'endgame', ->
      console.log(@$('.hit-button'))
    @model.get('dealerHand').on 'endgame', ->
      @$('.hit-button').attr "disabled", "true"
      #@render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  resetHands: ->
    @model.newDeal()
    @render()

