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
      if Math.max.apply(null, @get('playerHand').scores()) > 21
        playerScore = Math.min.apply(null, @get('playerHand').scores())
      else
        playerScore = Math.max.apply(null, @get('playerHand').scores())
      if playerScore > 21
        @set 'losses', @get('losses') + 1
      else
        @get('dealerHand').playDealerHand()
        dealerScore = Math.max.apply null, @get('dealerHand').scores()
        if dealerScore > 21
          @set 'wins', @get('wins') + 1
        else if playerScore > dealerScore
          @set 'wins', @get('wins') + 1
        else if playerScore != dealerScore
          @set 'losses', @get('losses') + 1
      @set 'isGameOver', true
    , @

