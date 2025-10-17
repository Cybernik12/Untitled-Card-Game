extends Node2D
class_name Deck_n_Hand

signal card_activated(card: UsableCard)

@export var debug_mode: bool = true:
	set(value):
		if !is_node_ready():
			await ready
		debug_mode = value
		$Button.visible = debug_mode
		$Button2.visible = debug_mode


@export var player1: Player1
@export var deck: Deck

@onready var charlie_card_data: CardData = preload("res://Card_Data/Charlie_card.tres")
@onready var draw_card_data: CardData = preload("res://Card_Data/Charlie_card.tres")

@onready var hand: Hand = $Hand

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func reset():
	hand.empty_hand()

func add_card(card_with_id: CardWithID):
	hand.add_card(card_with_id.card)

func _on_button_pressed():
	deck.add_card(charlie_card_data.duplicate())

func _on_button_2_pressed():
	deck.add_card(draw_card_data.duplicate())

func _on_hand_card_activated(card):
	card_activated.emit(card)

func _on_delete_card_pressed():
	if deck.get_cards().is_empty():
		return
	
	var random_card: CardWithID = deck.get_cards().pick_random()
	deck.remove_card(random_card.id)
	pass # Replace with function body.
