extends Node2D
class_name Card_old

# Drag and Drop Variables
var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2

# Base Card Variables
var cost
var attack
var defence
var type
var can_boost
var trigger
var effect
var sprite
var all_cards = {
	# Leader
	"Joe": 	 {"Cost": null, "Attack": 15000, "Defence": null, "Type": "Leader", "Can Boost": false, "Trigger": null, "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Leader/Leader (Front).png"},
	"Joe Mama": 	 {"Cost": null, "Attack": 25000, "Defence": null, "Type": "Leader", "Can Boost": false, "Trigger": null, "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Leader/Leader (Back).png"},

	# Creatures
	"Charlie": 	 {"Cost": 1, "Attack": 5000, "Defence": 10000, "Type": "Creature", "Can Boost": true, "Trigger": "Critical", "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Creature/Charley.png"},
	"Duncan": 	 {"Cost": 3, "Attack": 25000, "Defence": 10000, "Type": "Creature", "Can Boost": false, "Trigger": null, "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Creature/Duncan.png"},
	"IanNAnthony": 	 {"Cost": 1, "Attack": 5000, "Defence": 10000, "Type": "Creature", "Can Boost": true, "Trigger": "Draw", "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Creature/Ian and Anthony.png"},
	"Lewis": 	 {"Cost": 4, "Attack": 25000, "Defence": 5000, "Type": "Creature", "Can Boost": false, "Trigger": null, "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Creature/Lewis.png"},
	"Mama": 	 {"Cost": 1, "Attack": 5000, "Defence": 5000, "Type": "Creature", "Can Boost": true, "Trigger": null, "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Creature/Mama.png"},
	"Poet": 	 {"Cost": 1, "Attack": 5000, "Defence": 10000, "Type": "Creature", "Can Boost": true, "Trigger": "Heal", "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Creature/Poet.png"},
	"Shane": 	 {"Cost": 4, "Attack": 25000, "Defence": 5000, "Type": "Creature", "Can Boost": false, "Trigger": null, "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Creature/Shane.png"},
	"Simon": 	 {"Cost": 5, "Attack": 35000, "Defence": 0, "Type": "Creature", "Can Boost": false, "Trigger": null, "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Creature/Simon.png"},
	"Sips": 	 {"Cost": 2, "Attack": 20000, "Defence": 10000, "Type": "Creature", "Can Boost": false, "Trigger": null, "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Creature/Sips.png"},
	"Tom": 	 {"Cost": 3, "Attack": 15000, "Defence": 5000, "Type": "Creature", "Can Boost": false, "Trigger": null, "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Creature/Tom.png"},
	
	# Spells
	"Draw": 	 {"Cost": 3, "Attack": null, "Defence": null, "Type": "Spell", "Can Boost": false, "Trigger": null, "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Spells/Draw.png"},
	"Double Energy": 	 {"Cost": null, "Attack": null, "Defence": null, "Type": "Spell", "Can Boost": false, "Trigger": null, "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Spells/Energy.png"},
	"Rust": 	 {"Cost": 2, "Attack": null, "Defence": null, "Type": "Spell", "Can Boost": false, "Trigger": null, "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Spells/Rust.png"},
	
	# Items
	"Sword": 	 {"Cost": 2, "Attack": 10000, "Defence": null, "Type": "Equipment", "Can Boost": false, "Trigger": null, "Effect": null, "Sprite": "res://Assets/Sprites/Cards/Items/Sword.png"},
}

# Variables for state of cards
enum {
	InHand,
	InPlay,
	InMouse,
	FocusInHand,
	MoveDrawCardToHand,
	ReOrganiseHand,
}

var state = InHand

# Variables for draw card animation
@onready var card_size = $MarginContainer
@onready var Orig_Scale = scale

var startpos = Vector2()
var targetpos = Vector2()
var startrot = 0
var targetrot = 0
var t = 0
var DRAWTIME = 1
var ORGANISETIME = 0.5

var setup = true
var startscale = Vector2()
var cardpos = Vector2()
var zoomInSize = 2
var ZOOMINTIME = 0.2
var ReorganiseNeighbours = true
var numberCardsHand = 0
var Card_Numb = 0
var NeighbourCard

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match state:
		InHand:
			pass
		InPlay:
			pass
		InMouse:
			pass
		FocusInHand:
			if setup:
				Setup()
			if t <= 1: # Always be a 1
				position = startpos.lerp(targetpos, t)
				rotation = startrot * (1 - t) + targetrot * t
				scale = startscale * (1 - t) + Orig_Scale * 2 * t
				t += delta/float(ZOOMINTIME)
				if ReorganiseNeighbours:
					ReorganiseNeighbours = false
					#if Card_Numb - 1 >= 0:
						#Move_Neighbour_Card(Card_Numb - 1, true, 1) # true is left
					#if Card_Numb - 2 >= 0:
						#Move_Neighbour_Card(Card_Numb - 2, true,0.25)
					#if Card_Numb + 1 <= numberCardsHand:
						#Move_Neighbour_Card(Card_Numb + 1, false, 1)
					#if Card_Numb + 2 <= numberCardsHand:
						#Move_Neighbour_Card(Card_Numb + 2, false, 0.25)
			else:
				position = targetpos
				rotation = targetrot
				scale = Orig_Scale * 2
		MoveDrawCardToHand: # Animate from the deck to my hand
			if t <= 1: # Always be a 1
				position = startpos.lerp(targetpos, t)
				rotation = startrot * (1 - t) + targetrot * t
				scale.x = Orig_Scale.x * abs(2 * t - 1)
				if $MarginContainer/CardBack.visible:
					if t >= 0.5:
						$MarginContainer/CardBack.visible = false
				t += delta/float(DRAWTIME)
			else:
				position = targetpos
				rotation = targetrot
				state = InHand
				t = 0
		ReOrganiseHand:
			if setup:
				Setup()
			if t <= 1: # Always be a 1
				position = startpos.lerp(targetpos, t)
				rotation = startrot * (1 - t) + targetrot * t
				scale = startscale * (1 - t) + Orig_Scale * t
				t += delta/float(ORGANISETIME)
			else:
				position = targetpos
				rotation = targetrot
				scale = Orig_Scale
				state = InHand

func Move_Neighbour_Card(Card_Numb, Left, Spreadfactor):
	NeighbourCard = $Hand.get_child(Card_Numb) # Not working, need to find a way to reference the card that is currently zoomed in on.
	if Left:
		NeighbourCard.targetpos = NeighbourCard.Cardpos - Spreadfactor * Vector2(65 , 0)
	else:
		NeighbourCard.targetpos = NeighbourCard.Cardpos + Spreadfactor * Vector2(65 , 0)
	NeighbourCard.setup = true
	NeighbourCard.state = ReOrganiseHand

func Setup():
				startpos = position
				startrot = rotation
				startscale = scale
				t = 0
				setup = false

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
	#if not global.is_dragging:
		#draggable = true
		#scale = Vector2(1.05, 1.05)

	match state:
		InHand, ReOrganiseHand:
			setup = true
			targetrot = 0
			targetpos = cardpos
			targetpos.y = (get_viewport().size.y - (card_size.size.y / 2) * zoomInSize) + 2.5
			state = FocusInHand

func _on_area_2d_mouse_exited(): # Resets the size of the "Card" when the mouse is not over it
	#if not global.is_dragging:
		#draggable = false
		#scale = Vector2(1, 1)
	
	match state:
		FocusInHand:
			setup = true
			targetpos = cardpos
			state = ReOrganiseHand


func _on_area_2d_body_entered(body:StaticBody2D): # Changes the colour of the "Card Zone" if the "Card" is over it
	if body.is_in_group('dropable'):
		is_inside_dropable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		body_ref = body

func _on_area_2d_body_exited(body): # Changes the colour of the "Card Zone" if the "Card" is not over it
	if body.is_in_group('dropable'):
		is_inside_dropable = false
		body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)


