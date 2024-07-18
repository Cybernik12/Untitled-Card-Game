extends Node2D
class_name Card

# Drag and Drop Variables
var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2

# Base Card Variables
var cost
var attack
var deffence
var type

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _dragNdrop(): # Controls drag and drop functionality
		if draggable: # Checks to see if the "Card" is draggable
			if Input.is_action_just_pressed("click"):
				initialPos = global_position
				offset = get_global_mouse_position() - global_position
				global.is_dragging = true
			if Input.is_action_pressed("click"):
				global_position = get_global_mouse_position() - offset
			elif Input.is_action_just_released("click"):
				global.is_dragging = false
				var tween = get_tree().create_tween()
				if is_inside_dropable:
					tween.tween_property(self, "position" , body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
				else:
					tween.tween_property(self, "global_position" , initialPos, 0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered(): # Increases the size of the "Card" when the mouse is over it
	if not global.is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)

func _on_area_2d_mouse_exited(): # Resets the size of the "Card" when the mouse is not over it
	if not global.is_dragging:
		draggable = false
		scale = Vector2(1, 1)	

func _on_area_2d_body_entered(body:StaticBody2D): # Changes the colour of the "Card Zone" if the "Card" is over it
	if body.is_in_group('dropable'):
		is_inside_dropable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		body_ref = body

func _on_area_2d_body_exited(body): # Changes the colour of the "Card Zone" if the "Card" is not over it
	if body.is_in_group('dropable'):
		is_inside_dropable = false
		body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)


