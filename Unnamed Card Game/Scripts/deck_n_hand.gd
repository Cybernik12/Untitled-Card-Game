extends Node2D
class_name Deck_n_Hand

signal card_activated(card: UsableCard)

@onready var charlie_card_scene: PackedScene = preload("res://Scenes/Cards/charlie.tscn")
@onready var draw_card_scene: PackedScene = preload("res://Scenes/Cards/draw.tscn")

@onready var hand: Hand = $Hand

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Draw():
	var charlie_card = charlie_card_scene.instantiate()
	hand.add_card(charlie_card)

func _on_button_pressed():
	var charlie_card = charlie_card_scene.instantiate()
	hand.add_card(charlie_card)

func _on_button_2_pressed():
	var draw_card = draw_card_scene.instantiate()
	hand.add_card(draw_card)

func _on_hand_card_activated(card):
	card_activated.emit(card)
