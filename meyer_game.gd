extends Node2D

var value_1: int
var value_2: int
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var result_label: Label = $ResultLabel
var rolls = [21,31,66,55,44,33,22,11,65,64,63,62,61,54,53,52,51,43,42,41,32]
var currentRoll = rolls.size()
var statement = rolls.size()
var hasRolled = false
var viable = false
var ellerDerover = false
var statementTxt
var p1turn = true
var p1hp = 6
var p2hp = 6
var round = 1

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if p1turn == true:
		$whooseTurn.text="turn: player 1"
	else:
		$whooseTurn.text="turn: player 2"
	$p1hp.text="player 1 hp: "+str(p1hp)
	$p2hp.text="player 2 hp: "+str(p2hp)
	if p1hp>0:
		$victory.text=""
	else:
		$victory.text="PLAYER 1 IS FUCKING HORRIBLE AT VIDEOGAMES\n AND SHOULD UNINSTALL"
		p1turn = true
	if p2hp>0:
		$victory.text=""
	else:
		$victory.text="PLAYER 2 IS FUCKING HORRIBLE AT VIDEOGAMES\n AND SHOULD UNINSTALL"
		p1turn = true


func _on_button_pressed() -> void:
	if hasRolled==false:
		if p1hp==0 or p2hp==0:
			p1hp = 6
			p2hp = 6
			round = 1
		hasRolled=true
		ellerDerover=false
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
	else:
		hasRolled=false
		ellerDerover=true
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
		if statement == rolls.size():
			statement = rolls.size()-1
		makeStatement()
	
	
func _on_animated_sprite_2d_animation_finished() -> void:
	animated_sprite_2d.hide()
# Called when the node enters the scene tree for the first time.



func _on_button_2_pressed() -> void:
	if hasRolled==true:
		result_label.text += "\ndu har rullet"
	elif statement==rolls.size():
		result_label.text += "\ndu er først"
	else:
		if !ellerDerover:
			if currentRoll==statement:
				result_label.text = "\nWOMP WOMP! YOU LOSE!"
				if p1turn == true:
					p1hp-=1
				else:
					p2hp-=1
			else:
				result_label.text = "\nGOT EM! YOU WIN!"
				if p1turn == false:
					p1hp-=1
				else:
					p2hp-=1
		else:
			ellerDerover=false
			if currentRoll<=statement:
				result_label.text = "\nWOMP WOMP! YOU LOSE!"
				if p1turn == true:
					p1hp-=1
				else:
					p2hp-=1
			else:
				result_label.text = "\nGOT EM! YOU WIN!"
				if p1turn == false:
					p1hp-=1
				else:
					p2hp-=1
		currentRoll = rolls.size()
		statement = rolls.size()
		round+=1
		if round%2==0:
			p1turn = false
		else:
			p1turn = true


func _on_button_3_pressed() -> void:
	if currentRoll <= statement and hasRolled==true:
		statement=currentRoll
		hasRolled=false
		makeStatement()
	else:
		if hasRolled==false:
			result_label.text += "\ndu har ikke rullet"
		else:
			result_label.text += "\ndu rullede for lavt"


func _on_button_4_pressed() -> void:
	if hasRolled==false:
			result_label.text += "\ndu har ikke rullet"
	else:
		$Button4/LineEdit.show()
		$Button4/CheckBox.show()


func _on_line_edit_text_submitted(new_text: String) -> void:
	viable = false
	if new_text.is_valid_int():
		for i in rolls:
			if new_text.to_int() == i:
				viable = true
		if viable == true:
			if rolls.find(new_text.to_int()) <= statement:
				statement=rolls.find(new_text.to_int())
				$Button4/LineEdit.hide()
				$Button4/CheckBox.set_pressed_no_signal(false)
				$Button4/CheckBox.hide()
				hasRolled=false
				makeStatement()
					
			else: result_label.text += "\nintast et tal højere i værdi end "+str(rolls.get(statement))
		else:
				result_label.text += "\nintast et tal i meier (vis du vil intaste meier eller \nlille meier, skal du intaste henholdsvis 21 og 31)\n (vis du vil intaste fællesskål, lad vær (32))"
	else:
		result_label.text += "\nintast et tal i meier (vis du vil intaste meier eller \nlille meier, skal du intaste henholdsvis 21 og 31)\n (vis du vil intaste fællesskål, lad vær (32))"

func makeStatement():
	if statement==rolls.find(21):
		statementTxt = "\nder blev rullet meier!"
	elif statement==rolls.find(31):
		statementTxt = "\nder blev rullet lille meier!"
	elif statement<=rolls.find(11):
		statementTxt = "\nder blev rullet dobbelt "+str(rolls[statement]/11)+"!"
	elif statement<=rolls.find(41):
		statementTxt = "\nder blev rullet "+str(rolls[statement])+"!"
	else:
		statementTxt = "\nder blev rullet fællesskål!"
	if ellerDerover:
		statementTxt+=" (eller derover...)"
	result_label.text = statementTxt
	if p1turn:
		p1turn=false
	else:
		p1turn=true

func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		ellerDerover=true
	else:
		ellerDerover=false
