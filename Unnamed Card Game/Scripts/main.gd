extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ManaAmount.set_text(str($GameScreen/Player1.mana))
	pass

func _on_deck_n_hand_card_activated(card: UsableCard):
	card.activate({
		"caster": $GameScreen/Player1,
		"targets": [$GameScreen/Player2]
	})
	pass # Replace with function body.
