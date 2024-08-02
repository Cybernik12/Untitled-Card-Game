extends Node2D

var full_deck = [
	"Charlie", "Duncan", "IanNAnthony", "Lewis", "Mama", "Poet", "Shane", "Simon", "Sips", "Tom", "Draw", "Double Energy", "Rust", "Sword",
]

var current_deck = []

var scene
var is_clickable = false
var temp = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	scene = preload("res://Scenes/inherited_card.tscn") 
	current_deck = full_deck.duplicate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_clickable:
		if Input.is_action_just_released("click"):
			draw_card()


func draw_card(): # Draws and assigns card selected
	var me_cards = _new_card()
	
	var instance = scene.instantiate()
	instance.card_selected = me_cards
	instance.position.x = 960 + temp
	instance.position.y = 540
	temp -= 200
	
	get_tree().root.add_child(instance)

func _new_card(): # Returns random card from deck and then deletes it
	var card = current_deck[randi() % current_deck.size()]
	current_deck.erase(card)
	return card

func _on_area_2d_mouse_entered(): # Increases the size of the "Deck" when the mouse is over it
	is_clickable = true
	scale = Vector2(1.05, 1.05)

func _on_area_2d_mouse_exited(): # Resets the size of the "Deck" when the mouse is not over it]
	is_clickable = false
	scale = Vector2(1, 1)	
