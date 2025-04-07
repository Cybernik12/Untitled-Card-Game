extends Node2D

@export var debug_mode: bool = true:
	set(value):
		if !is_node_ready():
			await ready
		debug_mode = value
		$GameScreen/Button3.visible = debug_mode
		$GameScreen/ShowDeck.visible = debug_mode
		$GameScreen/DeleteCard.visible = debug_mode
		$DeckNHand.debug_mode = debug_mode

@export var deck_n_hand: Deck_n_Hand

@onready var gameState: GameState = $GameScreen as GameState
@onready var deck_view_window: DeckViewWindow = $CanvasLayer/DeckViewWindow as DeckViewWindow
@onready var deck_ui: PlayableDeckUI = $PlayableDeckUi

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

func _on_start_new_game_pressed():
	pass # Replace with function body.

func _on_playable_deck_ui_pressed():
	var card_with_id = deck_ui.draw()
	deck_n_hand.add_card(card_with_id)
	pass # Replace with function body.
