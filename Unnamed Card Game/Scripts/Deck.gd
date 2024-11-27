extends Node2D
class_name deck

var temp = 0

const card_scene = preload("res://Scenes/inherited_card.tscn") 

var full_deck = [
	"Charlie", "Duncan", "IanNAnthony", "Lewis", "Mama", "Poet", "Shane", "Simon", "Sips", "Tom", "Draw", "Double Energy", "Rust", "Sword",
]

@onready var current_deck = full_deck.duplicate()
@onready var deck_size = full_deck.size()

var is_clickable = false

# Oval Hand Position
@onready var CentreCardOval = get_viewport_rect().size * Vector2(0.5, 1.35)
@onready var Hor_rad = get_viewport_rect().size.x * 0.45
@onready var Ver_rad = get_viewport_rect().size.y * 0.4

var angle = 0
var card_numb = 0
var NumberCardsHand = 0
var cardSpread = 0.15
var OvalAngleVector = Vector2()

enum {
	InHand,
	InPlay,
	InMouse,
	FocusInHand,
	MoveDrawCardToHand,
	ReOrganiseHand,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	#current_deck = full_deck.duplicate()
	return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_clickable:
		if Input.is_action_just_released("click"):
			draw_card()

func draw_card(): # Draws and assigns card selected
	angle = PI/2 + cardSpread * (float(NumberCardsHand) / 2 - NumberCardsHand)

	var new_card = card_scene.instantiate()
	new_card.card_selected = _new_card()

	# Set Position and Rotation
	OvalAngleVector = Vector2(Hor_rad * cos(angle), -Ver_rad * sin(angle))
	new_card.startpos = $".".position
	new_card.targetpos = CentreCardOval + OvalAngleVector
	new_card.cardpos = new_card.targetpos
	new_card.startrot = 0
	new_card.targetrot = (PI/2 - angle) / 4
	new_card.state = MoveDrawCardToHand
	new_card.numberCardsHand = NumberCardsHand + 1 # offset for zeroth item
	new_card.Card_Numb = NumberCardsHand
	card_numb = 0

	for Card in $"../Hand".get_children(): # reorganise hand
		angle = PI/2 + cardSpread * (float(NumberCardsHand) / 2 - card_numb)
		OvalAngleVector = Vector2(Hor_rad * cos(angle), - Ver_rad * sin(angle))

		Card.targetpos = CentreCardOval + OvalAngleVector
		Card.cardpos = Card.targetpos # Card default position
		Card.startrot = Card.rotation
		Card.targetrot = (PI/2 - angle) / 4
		Card.Card_Numb = card_numb
		card_numb += 1

		if Card.state == InHand:
			Card.state = ReOrganiseHand
			Card.startpos = Card.position
		elif Card.state == MoveDrawCardToHand:
			Card.startpos = Card.targetpos - ((Card.targetpos - Card.position / (1 - Card.t)))
	
	$"../Hand".add_child(new_card)
	
	angle += 0.15
	NumberCardsHand += 1
	# card_numb += 1
	# get_tree().root.add_child(instance)

func _new_card(): # Returns random card from deck and then deletes it
	var card = current_deck[randi() % current_deck.size()]
	current_deck.erase(card)
	# deck_size = current_deck.size()
	return card

func _on_area_2d_mouse_entered(): # Increases the size of the "Deck" when the mouse is over it
	is_clickable = true
	scale = Vector2(1.05, 1.05)

func _on_area_2d_mouse_exited(): # Resets the size of the "Deck" when the mouse is not over it]
	is_clickable = false
	scale = Vector2(1, 1)	
