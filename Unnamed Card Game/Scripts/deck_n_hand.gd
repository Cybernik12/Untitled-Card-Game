extends Node2D

@onready var charlie_card_scene: PackedScene = preload("res://Scenes/Cards/charlie.tscn")
@onready var draw_card_scene: PackedScene = preload("res://Scenes/Cards/draw.tscn")

@onready var spawn_point = $CanvasLayer/SpawnPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var charlie_card = charlie_card_scene.instantiate()
	spawn_point.add_child(charlie_card)


func _on_button_2_pressed():
	var draw_card = draw_card_scene.instantiate()
	spawn_point.add_child(draw_card)
