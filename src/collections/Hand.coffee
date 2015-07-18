class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @deck.last()

  checkscore: -> 

    if @isDealer && @getScore() >= 17
      @trigger 'endgame', @

    if @scores()[0] == 21
      @trigger 'endgame'
      @trigger 'blackjack'

    if @scores()[0] > 21
      @trigger 'endgame'
      @trigger 'busted'

  #TODO Change this back to "is 1"
  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  # This checks dealer's score based on minScore and minScore + Ace
  # It returns whatever score hasn't busted the dealer.
  getScore: ->
    if @scores()[1] > 21
      @scores()[0]
    else
      @scores()[1]

  # Carry out dealer actions by flipping first card and then hitting.
  dealerMove: ->
    @at(0).set('revealed', true)
    @hit()
    

