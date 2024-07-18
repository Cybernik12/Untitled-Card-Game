extends Card

# Called when the node enters the scene tree for the first time.
func _ready():
	cost = 1
	attack = 5000
	deffence = 10000
	type = "Creature"
	
	print ("Cost: " + str(cost))
	print ("Attack: " + str(attack))
	print ("Deffence: " + str(deffence))
	print ("Type: " + type)

func _process(delta):
	_dragNdrop()
