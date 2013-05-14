class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    if Math.min.apply(null, @scores()) > 21 then @trigger('gameOver', @)

  stand: ->
    @trigger('gameOver', @)

  pickScore: (array)->
    if array.length == 1
      return array[0]
    else
      if Math.max.apply(null, array) < 22
        return Math.max.apply(null, array)
      else
        return Math.min.apply(null, array)

  playDealerHand: ->
    if !@at(0).get('revealed')
      @at(0).flip()
    scores = @scores()
    scores = @pickScore(scores)
    if scores < 17
      @hit()
      @playDealerHand()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or ((card.get('revealed') and card.get('value') is 1))
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
