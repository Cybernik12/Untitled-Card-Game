extends Node2D

@export var deck_n_hand: Deck_n_Hand

enum Phase {
	# On players turn.
	Setup, # All cards are unrested.
	Draw, # You draw a card from your deck.
	Energy, # You can add a card from hand into your Energy area.
	Play, # You can use your energy to play a card.
	Attack, # You can attack with your cards.
	End, # Turn ends, then it becomes your opponents turn.
	
	#On Opponents Turn.
	Defend, # You can defend an attack.
	Damage, # If the attack was succesful, you take damage.
}

var game_phase = Phase.Setup

# Called when the node enters the scene tree for the first time.
func _ready():
	print(game_phase)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Game_Phase_Controller():
	match game_phase:
		Phase.Setup: # All cards are unrested.
			game_phase = Phase.Draw
		Phase.Draw: # You draw a card from your deck.
			_draw()
			game_phase = Phase.Energy
		Phase.Energy: # You can add a card from hand into your Energy area.
			game_phase = Phase.Play
		Phase.Play: # You can use your energy to play a card.
			game_phase = Phase.Attack
		Phase.Attack: # You can attack with your cards.
			game_phase = Phase.End
		Phase.End: # Turn ends, then it becomes your opponents turn.
			game_phase = Phase.Defend
		#On Opponents Turn.
		Phase.Defend: # You can defend an attack.
			game_phase = Phase.Damage
		Phase.Damage: # If the attack was succesful, you take damage.
			game_phase = Phase.Setup

func _draw():
	deck_n_hand.Draw()

func _on_button_3_pressed():
	Game_Phase_Controller()
	print(game_phase)
