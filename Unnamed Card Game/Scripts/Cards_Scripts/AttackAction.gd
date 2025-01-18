extends Node2D

@export var mana: int = 1

func activate(game_state: Dictionary):
	# Spend Cost
	game_state.get("caster").spend_mana(mana)
	# Damage 1
	pass
