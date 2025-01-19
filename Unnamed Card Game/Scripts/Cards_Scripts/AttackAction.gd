extends Node2D

@export var card: Card

@onready var mana: int = card.card_cost

func activate(game_state: Dictionary):
	# Spend Cost
	game_state.get("caster").spend_mana(mana)
	# Damage 1
	pass
