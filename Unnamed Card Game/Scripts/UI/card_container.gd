extends Container
class_name Card_Container

const CARD_COMPONENT_POSITION: Vector2 = Vector2(100, 138)

var card: UsableCard:
	set(_card):
		card = _card
		card.set_position(CARD_COMPONENT_POSITION)
		add_child(card)

