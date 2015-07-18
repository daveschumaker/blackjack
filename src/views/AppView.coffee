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
      @model.get('playerHand').stand()
      while @model.get('dealerHand').scores()[0] < 21
        @dealerMove()
    'click .new-game': -> @resetHands()



  initialize: ->
    # @model.get('playerHand').on 'change', =>
    #   console.log('new hand')
    #   @render()
    @render()

    @model.get('dealerHand').on 'endgame', =>
      console.log('endgame')

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  dealerMove: ->
    @model.get('dealerHand').at(0).set('revealed', true)
    @model.get('dealerHand').hit()

  resetHands: ->
    @model.newDeal()
    @render()

