@tool
extends Node2D
class_name Hand

signal card_activated(card: UsableCard)

@export var deck_n_hand: Deck_n_Hand

@export var hand_radius: int = 1000
@export var card_angle: float = -90
@export var angle_limit: float = 25
@export var max_card_spread_angle: float = 5

@onready var collision_shape: CollisionShape2D = $DebugShape
@onready var usable_card_scene: PackedScene = preload("res://Scenes/Cards/UsableCard.tscn")

var hand: Array[UsableCard] = []
var touched: Array[UsableCard] = []
var current_selected_card_index: int = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("mouse_click") && current_selected_card_index >= 0:
		var card = hand[current_selected_card_index]
		var stats = card._get_card_stats(); # 0 = cost, 1 = name, 2 = effect, 3 = atk, 4 = def
		var p1_mana = deck_n_hand.player1.mana
		
		if stats[0] <= p1_mana:
			remove_card((current_selected_card_index))
			card_activated.emit(card)
			current_selected_card_index = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for card in hand:
		current_selected_card_index = -1
		card.unhighlight()
	
	if !touched.is_empty():
		var highest_touched_index: int = -1
		
		for touched_card in touched:
			highest_touched_index = max(highest_touched_index, hand.find(touched_card))
			
		if highest_touched_index >= 0 && highest_touched_index < hand.size():
			hand[highest_touched_index].highlight()
			current_selected_card_index = highest_touched_index
	
	# Tool logic
	if (collision_shape.shape as CircleShape2D).radius != hand_radius:
		(collision_shape.shape as CircleShape2D).set_radius(hand_radius)

func empty_hand():
	current_selected_card_index = -1
	for card in hand:
		card.queue_free()
	hand = []
	touched = []

func get_card_position(angle_in_deg: float) -> Vector2:
	var x: float = hand_radius * cos(deg_to_rad(angle_in_deg))
	var y: float = hand_radius * sin(deg_to_rad(angle_in_deg))
	
	return Vector2(x, y)

func add_card(card_data: CardData):
	var usable_card = usable_card_scene.instantiate()
	hand.push_back(usable_card)
	add_child(usable_card)
	usable_card.load_card_data(card_data)
	usable_card.mouse_entered.connect(_handle_card_touched)
	usable_card.mouse_exited.connect(_handle_card_untouched)
	reposition_cards()

func remove_card(index: int) -> Node2D:
	var removing_card = hand[index]
	hand.remove_at(index)
	touched.remove_at(touched.find(removing_card))
	remove_child(removing_card)
	reposition_cards()
	return removing_card

func remove_card_by_entity(card: UsableCard):
	var remove_index = hand.find(card)
	remove_card(remove_index)

func reposition_cards():
	var card_spread = min(angle_limit / hand.size(), max_card_spread_angle)
	var current_angle = -(card_spread * (hand.size() - 1)) / 2 - 90
	for card in hand:
		_update_card_transform(card, current_angle)
		current_angle += card_spread

func _update_card_transform(card: UsableCard, angle_in_drag: float):
	card.set_position(get_card_position(angle_in_drag))
	card.set_rotation(deg_to_rad(angle_in_drag + 90))

func _handle_card_touched(card):
	touched.push_back(card)

func _handle_card_untouched(card):
	touched.remove_at(touched.find(card))
