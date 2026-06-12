extends Area2D

var activated = false
@export var checkpoint_id := 0

func _ready():
    add_to_group("checkpoints")
    body_entered.connect(_on_body_entered)

func _on_body_entered(body):
    if body.is_in_group("player") and not activated:
        activated = true
        print("到达重生点 " + str(checkpoint_id))
        # 改变颜色表示已激活
        $ColorRect.color = Color(0, 1, 0, 0.8)