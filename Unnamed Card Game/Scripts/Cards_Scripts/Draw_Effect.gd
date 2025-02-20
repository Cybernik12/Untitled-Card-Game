extends Card_Effects

func activate(game_state: Dictionary, deck_n_hand: Deck_n_Hand):
	# Spend Cost
	Spend_cost(game_state)
	# Play Effect	
	Draw(deck_n_hand)
	Draw(deck_n_hand)
	pass
