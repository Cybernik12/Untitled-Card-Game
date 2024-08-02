extends Card

var card_selected

# Called when the node enters the scene tree for the first time.
func _ready():	
	cost = all_cards[card_selected]["Cost"]
	attack = all_cards[card_selected]["Attack"]
	defence = all_cards[card_selected]["Defence"]
	type = all_cards[card_selected]["Type"]
	can_boost = all_cards[card_selected]["Can Boost"]
	trigger = all_cards[card_selected]["Trigger"]
	effect = all_cards[card_selected]["Effect"]
	sprite = all_cards[card_selected]["Sprite"]
	$Sprite2D.texture = load(sprite)
	
	print(card_selected)

func _process(delta):
	_dragNdrop()
