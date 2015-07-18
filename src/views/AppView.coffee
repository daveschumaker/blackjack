class window.AppView extends Backbone.View
  
  className: 'gameboard'

  template: _.template '
    <div class="button-container">
      <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
      <button class="new-game">New Game</button>
    </div>
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> 
      while @model.get('dealerHand').dealerScore() < 17
        @model.get('dealerHand').dealerMove()

    'click .new-game': -> @resetHands()


  initialize: ->
    @model.get('playerHand').on 'endgame', =>
      @$('.hit-button').prop "disabled", "true"
    @model.get('dealerHand').on 'endgame', =>
      @$('.stand-button').prop "disabled", "true"
    @model.get('playerHand').on 'blackjack', =>
      @$('.player-hand-container .score').text 'BLACKJACK!'
    @model.get('playerHand').on 'busted', =>
      $('.player-hand-container .score').text 'BUSTED!'
      @$('.score').text 'WINS!'
    @model.get('dealerHand').on 'blackjack', =>
      @$('.dealer-hand-container .score').text 'BLACKJACK!'
    @model.get('dealerHand').on 'busted', =>
      @$('.dealer-hand-container .score').text 'BUSTED!'
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el

  resetHands: ->
    @model.newDeal()
    @render()

