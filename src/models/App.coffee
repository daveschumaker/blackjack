# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  newDeal: ->
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()

  compareScores: ->
    if @get('playerHand').getScore() <= 21 and @get('dealerHand').getScore() > 21
      alert 'YOU WIN!'
    else if @get('playerHand').getScore() <= 21 and @get('playerHand').getScore() > @get('dealerHand').getScore() 
      alert 'YOU WIN!'
    else if @get('playerHand').getScore() == @get('dealerHand').getScore()
      alert 'push.'
    else
      alert 'YOU LOSE.....'