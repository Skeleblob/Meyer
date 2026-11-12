extends Node2D

var value_1: int
var value_2: int
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"


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

	
	print(highest, " ", lowest)
	
	
func _on_animated_sprite_2d_animation_finished() -> void:
	animated_sprite_2d.hide()
	
