class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <h3>Wins : <%= wins %> Losses : <%= losses %></h3>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .new-game": -> @model.newGame()

  initialize: ->
    @model.on 'change:isGameOver', ->
      @render()
      $('button').prop 'disabled', @model.get('isGameOver')
      if @model.get('isGameOver')
        @$el.prepend('<button class="new-game">New Game</button>')
      return
    , @
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template(@model.attributes)
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
