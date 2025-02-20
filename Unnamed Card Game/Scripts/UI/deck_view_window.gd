extends ScrollContainer
class_name DeckViewWindow

@onready var card_container_scn: PackedScene = preload("res://Scenes/UI/card_container.tscn")

@onready var flow_container = $HFlowContainer

var cached_card_container: Array[Card_Container] = []

func clear_display():
	for child in flow_container.get_children():
		flow_container.remove_child(child)

func display_card_list(cardsWithID: Array[CardWithID]):
	clear_display()
	while cached_card_container.size() < cardsWithID.size():
		cached_card_container.push_back(card_container_scn.instantiate() as Card_Container)
	
	for i in cardsWithID.size():
		var cardWithID: CardWithID = cardsWithID[i] as CardWithID
		var card_container: Card_Container = cached_card_container[i]
		card_container.card = cardWithID.card
		flow_container.add_child(card_container)
