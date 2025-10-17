extends Node2D
class_name Player1

@export var mana: int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func spend_mana(amount: int):
	mana -= amount

func return_mana():
	return mana

func take_damage():
	pass
