extends CharacterBody2D

var score = 0
var checkpoints = []
@onready var score_label = get_node("/root/Main/CanvasLayer/ScoreLabel")

func _ready():
    add_to_group("player")
    $Camera2D.make_current()
    # 收集所有重生点
    for node in get_tree().get_nodes_in_group("checkpoints"):
        checkpoints.append(node.global_position)
    # 起点作为第一个重生点
    checkpoints.push_front(global_position)

func _physics_process(delta):
    # 掉出地图重生（安全兜底）
    if global_position.y > 700:
        respawn()
        return

    var direction = 0
    if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
        direction = -1
    if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
        direction = 1
    velocity.x = direction * 300
    if not is_on_floor():
        velocity.y += 900 * delta
    if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
        velocity.y = -450
    move_and_slide()

func respawn():
    # 传送到最近已通过的复活点
    var target = checkpoints[0]
    for cp in checkpoints:
        if global_position.x >= cp.x - 50:
            target = cp
        else:
            break
    position = target
    velocity = Vector2.ZERO
    print("重生！")

func _on_coin_collected():
    score += 1
    if score_label:
        score_label.text = "Score: " + str(score)
    print("Coin collected! Score: ", score)

func _on_finish_entered():
    print("通关！")
    get_tree().reload_current_scene()