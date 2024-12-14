extends Card_old

var card_selected

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print(numberCardsHand)
	
	cost = all_cards[card_selected]["Cost"]
	attack = all_cards[card_selected]["Attack"]
	defence = all_cards[card_selected]["Defence"]
	type = all_cards[card_selected]["Type"]
	can_boost = all_cards[card_selected]["Can Boost"]
	trigger = all_cards[card_selected]["Trigger"]
	effect = all_cards[card_selected]["Effect"]
	sprite = all_cards[card_selected]["Sprite"]
	$MarginContainer/Card.texture = load(sprite)
	
	print("Number of card: ", card_selected)

func _process(delta):
	_dragNdrop()
