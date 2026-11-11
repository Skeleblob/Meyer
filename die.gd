extends Node2D

var value_1: int
var value_2: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_button_pressed() -> void:
	value_1 = randi_range(1, 6)
	value_2 = randi_range(1, 6)
	
	var highest = max(value_1, value_2)
	var lowest = min(value_1, value_2)

	
	print(highest, " ", lowest)
	
