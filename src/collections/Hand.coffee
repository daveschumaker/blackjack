class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @deck.last()

  checkscore: -> 
    if @isDealer
      playerName = "Dealer"
    else
      playerName = "Player"

    if @scores()[1] == 21
      console.log(playerName + ' BLACKJACK!')
      @trigger 'endgame'

    if @scores()[1] > 21
      console.log(playerName + ' busted: ' + @scores()[1] + ' Num of Cards: ' + @length)
      @trigger 'endgame'
    #console.log('Real score: ' + @scores()[0])
    #console.log('Fake score: ' + @scores()[1])

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

  stand: ->

  dealerMove: ->
    @at(0).set('revealed', true)
    @hit()

