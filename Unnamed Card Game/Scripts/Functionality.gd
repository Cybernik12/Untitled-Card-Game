extends Node
class_name Func

@export var card: Card

@onready var mana: int = card.card_cost

var isPlayable: bool

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Checks to see if the player has enough mana to play the card.
func EnoughMana(game_state: Dictionary):
	var pmana = game_state.get("caster").return_mana()
	if mana <= pmana:
		isPlayable = true

func Draw():
	pass
