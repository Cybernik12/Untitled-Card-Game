extends Node2D
class_name PlayableDeckUI

var deck: PlayableDeck

func draw() -> CardWithID:
	return deck.draw_card()
