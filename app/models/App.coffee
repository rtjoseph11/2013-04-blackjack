#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'wins', 0
    @set 'losses', 0
    @newGame()
    return
  newGame: ->
    @set 'deck' , deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'isGameOver', false
    @get('playerHand').on 'gameOver', ->
      playerScore = Math.max.apply null, @get('playerHand').scores()
      dealerScore = Math.max.apply null, @get('dealerHand').scores()
      if playerScore > 21
        @set 'losses', @get('losses') + 1
      else if playerScore > dealerScore
        @set 'wins', @get('wins') + 1
      else if playerScore != dealerScore
        @set 'losses', @get('losses') + 1
      @set 'isGameOver', true
    , @

