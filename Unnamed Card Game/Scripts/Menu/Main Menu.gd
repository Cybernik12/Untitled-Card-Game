extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Play.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_deck_edit_pressed():
	pass # Replace with function body.

func _on_shop_pressed():
	pass # Replace with function body.

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu/settings_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
