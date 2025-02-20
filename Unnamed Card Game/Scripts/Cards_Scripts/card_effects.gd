extends Node2D
class_name Card_Effects

@export var card: Card

@onready var cost: int = card.card_cost
@onready var atk: int = card.card_atk
@onready var def: int = card.card_def

@onready var charlie_card_scene: PackedScene = preload("res://Scenes/Cards/charlie.tscn")
@onready var draw_card_scene: PackedScene = preload("res://Scenes/Cards/draw.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Spend_cost(game_state: Dictionary):
	game_state.get("caster").spend_mana(cost)
	pass

func Draw(decn_n_hand: Deck_n_Hand):
	# Draw cards
	var charlie_card = charlie_card_scene.instantiate()
	decn_n_hand.hand.add_card(charlie_card)


