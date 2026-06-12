extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("hello world")