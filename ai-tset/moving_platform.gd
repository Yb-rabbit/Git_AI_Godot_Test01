extends AnimatableBody2D

@export var move_axis := 0  # 0=X轴(水平), 1=Y轴(垂直)
@export var move_range := 100.0
@export var move_speed := 100.0

var start_pos: Vector2
var time := 0.0

func _ready():
    start_pos = position

func _physics_process(delta):
    time += delta * move_speed
    var offset = sin(time) * move_range
    if move_axis == 0:
        position.x = start_pos.x + offset
    else:
        position.y = start_pos.y + offset