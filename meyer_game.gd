extends Node2D

var value_1: int
var value_2: int
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var result_label: Label = $ResultLabel
var rolls = [21,31,66,55,44,33,22,11,65,64,63,62,61,54,53,52,51,43,42,41,32]
var currentToBeat = rolls.size()
var currentRoll = rolls.size()
var statement = rolls.size()
var hasRolled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(currentToBeat)


func _on_button_pressed() -> void:
	currentToBeat=statement
	hasRolled=true
	animated_sprite_2d.show()
	animated_sprite_2d.play("default")
	
	value_1 = randi_range(1, 6)
	value_2 = randi_range(1, 6)
	
	var highest = max(value_1, value_2)
	var lowest = min(value_1, value_2)
	var rollInString = str(highest)+str(lowest)
	for i in rolls:
		if i == rollInString.to_int():
			currentRoll=rolls.find(i)
	if value_1 == value_2:
		result_label.text = "Du slog to ens!\nBegge terninger viser: %d" % value_1
	
	elif lowest == 1 and highest == 3:
		result_label.text = "Du slog lille Meyer!\n %d  %d" % [
			lowest,
			highest
		]
	elif lowest == 1 and highest == 2:
		result_label.text = "Du slog Meyer!\n %d  %d" % [
			lowest,
			highest
		]
	elif highest == 3 and lowest == 2:	
		result_label.text = "Du slog fællesskål!\n %d %d" % [
			highest,
			lowest
		]
	
	else:
		result_label.text = "Højeste terning: %d\nLaveste terning: %d" % [
			highest,
		 	lowest
	]
		
	print(highest, "", lowest)
	
	
func _on_animated_sprite_2d_animation_finished() -> void:
	animated_sprite_2d.hide()
# Called when the node enters the scene tree for the first time.



func _on_button_2_pressed() -> void:
	if hasRolled==true:
		result_label.text += "\ndu har rullet"
	elif statement==21:
		result_label.text += "\ndu er først"
	else:
		if currentRoll==statement:
			result_label.text = "\nWOMP WOMP!"
		else:
			result_label.text = "\nGOT EM!"


func _on_button_3_pressed() -> void:
	if currentRoll <= currentToBeat and hasRolled==true:
		statement=currentRoll
		hasRolled=false
		if statement==rolls.find(21):
			result_label.text = "\nder blev rullet meier!"
		elif statement==rolls.find(31):
			result_label.text = "\nder blev rullet lille meier!"
		elif statement<=rolls.find(11):
			result_label.text = "\nder blev rullet dobbelt "+str(rolls[statement]/11)+"!"
		elif statement<=rolls.find(41):
			result_label.text = "\nder blev rullet "+str(rolls[statement])+"!"
		else:
			result_label.text = "\nder blev rullet fællesskål!"
	else:
		if hasRolled==false:
			result_label.text += "\ndu har ikke rullet"
		else:
			result_label.text += "\ndu rullede for lavt"


func _on_button_4_pressed() -> void:
	hasRolled=false
