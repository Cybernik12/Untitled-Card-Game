@tool
extends Node2D
class_name Hand

@export var hand_radious: int = 1000
@export var card_angle: float = -90
@export var angle_limit: float = 25
@export var max_card_spread_angle: float = 5

@onready var test_card = $TestCard
@onready var collision_shape: CollisionShape2D = $DebugShape

var hand: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Tool logic
	if (collision_shape.shape as CircleShape2D).radius != hand_radious:
		(collision_shape.shape as CircleShape2D).set_radius(hand_radious)

func get_card_position(angle_in_deg: float) -> Vector2:
	var x: float = hand_radious * cos(deg_to_rad(angle_in_deg))
	var y: float = hand_radious * sin(deg_to_rad(angle_in_deg))
	
	return Vector2(x, y)

func add_card(card: Node2D):
	hand.push_back(card)
	add_child(card)
	reposition_cards()

func reposition_cards():
	var card_spread = min(angle_limit / hand.size(), max_card_spread_angle)
	var current_angle = -(card_spread * (hand.size() - 1)) / 2 - 90
	for card in hand:
		_update_card_transform(card, current_angle)
		current_angle += card_spread

func _update_card_transform(card: Node2D, angle_in_drag: float):
	card.set_position(get_card_position(angle_in_drag))
	card.set_rotation(deg_to_rad(angle_in_drag + 90))
	
