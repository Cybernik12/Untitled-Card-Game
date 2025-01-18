extends Node2D
class_name UsableCard

signal mouse_entered(card: Card)
signal mouse_exited(card: Card)

@export var action: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func highlight():
	$Card.highlight()

func unhighlight():
	$Card.unhighlight()

func _on_card_mouse_entered(card):
	mouse_entered.emit(self)

func _on_card_mouse_exited(card):
	mouse_exited.emit(self)

func activate(game_state: Dictionary):
	action.activate(game_state)
