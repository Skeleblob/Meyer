extends Node2D

var value_1: int
var value_2: int
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var result_label: Label = $"../ResultLabel"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_button_pressed() -> void:
	animated_sprite_2d.show()
	animated_sprite_2d.play("default")
	
	value_1 = randi_range(1, 6)
	value_2 = randi_range(1, 6)
	
	var highest = max(value_1, value_2)
	var lowest = min(value_1, value_2)

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
	elif highest == 6 and lowest == 5:
		result_label.text = "Du slog fem-og-tres!\n %d %d" % [
			highest,
			lowest
		]	
	elif highest == 3 and lowest == 2:	
		result_label.text = "Du slog fem-og-tres!\n %d %d" % [
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
	
