class window.AppView extends Backbone.View
  
  className: 'gameboard'

  template: _.template '
    <div class="game-results"></div>
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
      @$('.stand-button').prop 'disabled', true
      while @model.get('dealerHand').getScore() < 17
        @model.get('dealerHand').dealerMove()
    'click .new-game': -> @resetHands()


  initialize: ->
    @model.get('playerHand').on 'endgame', =>
      @$('.hit-button').prop "disabled", "true"
      @$('.stand-button').prop "disabled", "true"
      $('.game-results').text @model.compareScores()
      $('.game-results').css 'display' 'block'
    @model.get('dealerHand').on 'endgame', =>
      @$('.stand-button').prop "disabled", "true"
      $('.game-results').text @model.compareScores()
      $('.game-results').css 'display' 'block'
    @model.get('playerHand').on 'blackjack', =>
      @$('.player-hand-container .score').text '21!'
    @model.get('playerHand').on 'busted', =>
      console.log('player busted!')
      console.log(@$('#playerscore').text())
      $('#playerscore').text 'BUSTED!'
      @$('#dealerscore').text 'WINS!'
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
    @initialize()
    @render()

