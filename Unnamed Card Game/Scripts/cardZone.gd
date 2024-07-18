extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(Color.MEDIUM_PURPLE, 0.7)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_isVisible()

func _isVisible(): # Makes the object invisble when the card is not being dragged (Good to show what zones the cards can be placed in)
	if global.is_dragging:
		visible = true
	else:
		visible = false
