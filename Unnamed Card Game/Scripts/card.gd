extends Node2D
class_name Card

@export var card_image: Sprite2D
@export var card_cost: int = 1
@export var card_name: String = "Charlie / Creature / Critical / Boost"
@export var card_effect: String = " No Effect."
@export var card_atk: int = 5000
@export var card_def: int = 10000

@onready var cost_lbl: Label = $CostDisplay/CostLbl
@onready var name_lbl: Label = $NameDisplay/NameLbl
@onready var effect_lbl: Label = $EffectDisplay/EffectLbl
@onready var atk_lbl: Label = $AttackDisplay/AtkLbl
@onready var def_lbl: Label = $DefenceDisplay/DefLbl

# Called when the node enters the scene tree for the first time.
func _ready():
	set_card_values(card_cost, card_name, card_effect, card_atk, card_def)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_card_values(_cost: int, _name: String, _effect: String, _atk: int, _def: int):
	
	card_cost = _cost
	card_name = _name
	card_effect = _effect
	card_atk = _atk
	card_def = _def
	
	cost_lbl.set_text(str(_cost))
	name_lbl.set_text(_name)
	effect_lbl.set_text(_effect)
	atk_lbl.set_text("Atk: " + str(_atk))
	def_lbl.set_text("Def: " + str(_def))
