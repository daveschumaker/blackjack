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
    # if @get('playerHand').scores()[1] > 21
    #   # hide the larger score.
    # if @get('dealerHand').scores()[0] > 21
    #   # hide the larger score.
