extends Container
class_name Card_Container

const CARD_COMPONENT_POSITION: Vector2 = Vector2(100, 138)

@onready var usable_card_scene = preload("res://Scenes/Cards/UsableCard.tscn")

var usable_card: UsableCard

var card: CardData:
	set(_card):
		if !is_node_ready():
			await ready
		
		card = _card
		var usable_card = usable_card_scene.instantiate()
		add_child(usable_card)
		usable_card.set_position(CARD_COMPONENT_POSITION)
		usable_card.load_card_data(card)

