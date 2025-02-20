extends Node2D

@export var deck_n_hand: Deck_n_Hand

@onready var gameState: GameState = $GameScreen as GameState
@onready var deck_view_window: DeckViewWindow = $CanvasLayer/DeckViewWindow as DeckViewWindow

@onready var deck: Deck = Deck.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	deck_n_hand.deck = deck
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ManaAmount.set_text(str($GameScreen/Player1.mana))
	pass

func _on_deck_n_hand_card_activated(card: UsableCard):
	card.activate({
		"caster": $GameScreen/Player1,
		"targets": [$GameScreen/Player2]
	}, deck_n_hand)

func _on_show_deck_pressed():
	gameState.Pause()
	deck_view_window.visible = true
	deck_view_window.display_card_list(deck.get_cards())
