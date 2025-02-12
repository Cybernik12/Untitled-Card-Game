extends Func

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate(game_state: Dictionary):
	EnoughMana(game_state)
	if isPlayable == true:
		game_state.get("caster").spend_mana(mana)
