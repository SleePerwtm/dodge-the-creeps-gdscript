extends Area2D

signal hit # 玩家与敌人碰撞时发出的信号

@export var speed: float = 400.0

var screen_size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# 计算每帧的速度单位向量
	var velocity := Vector2.ZERO
	if Input.is_action_pressed(&"move_up"):
		velocity.y -= 1
	if Input.is_action_pressed(&"move_down"):
		velocity.y += 1
	if Input.is_action_pressed(&"move_right"):
		velocity.x += 1
	if Input.is_action_pressed(&"move_left"):
		velocity.x -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	# 计算得到每帧更新的位置
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	# 根据运动状况设置动画的播放
	if velocity.x != 0:
		$AnimatedSprite2D.play(&"walk")
		$AnimatedSprite2D.flip_v = velocity.y > 0
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.play(&"up")
		$AnimatedSprite2D.flip_v = velocity.y > 0
	else:
		$AnimatedSprite2D.stop()


func _on_body_entered(body: Node2D) -> void:
	hide() # 玩家被击中后消失
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos: Vector2) -> void:
	position = pos
	show()
	$CollisionShape2D.disabled = false
