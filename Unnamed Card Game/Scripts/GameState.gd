extends Node2D
class_name GameState

@export var deck_n_hand: Deck_n_Hand

var is_running: bool = true

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

func Game_Phase_Controller():
	match game_phase:
		Phase.Setup: # All cards are unrested.
			game_phase = Phase.Draw
		Phase.Draw: # You draw a card from your deck.
			# _draw()
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

func Pause():
	is_running = false

func UnPause():
	is_running = true	

func _on_button_3_pressed():
	var temp
	match game_phase:
		0: # All cards are unrested.
			temp = "Setup"
		1: # You draw a card from your deck.
			temp = "Draw"
		2: # You can add a card from hand into your Energy area.
			temp = "Energy"
		3: # You can use your energy to play a card.
			temp = "Play"
		4: # You can attack with your cards.
			temp = "Attack"
		5: # Turn ends, then it becomes your opponents turn.
			temp = "End"

		#On Opponents Turn.
		6: # You can defend an attack.
			temp = "Defend"
		7: # If the attack was succesful, you take damage.
			temp = "Damage"
	print(temp)
	
	Game_Phase_Controller()

func Setup():
	# Stand all the characters on the field
	# Activate any Setup Effects
	pass

func Draw():
	# Draw 5 cards in starting hand if it is the starting turn
	# Be able to muligan once if it is the starting turn
	# Draw 1 card at the start of your turn
	pass

func Energy():
	# Allow the player to choose a card in hand to put into their energy area
	pass

func Play():
	# Allow the player to play character cards from their hand, depending on cost
	# Activate effects of the characters when conditions are met eg. "On Play", "Activate Main"
	# Be able to declare an attack
	pass

func Attack():
	# Rest attacking character/leader
	# Choose target of attack
	# Move onto Defend/Damage Phase
	pass

func Defend():
	# Activate Defender to redirect attack
	# Use cards in hand to block attacks
	pass

func Damage():
	# Take the top card of life and put it into the damage zone
	# If the card has a trigger, activate the trigger effect
	pass

func End():
	# End the turn to the next player
	pass
