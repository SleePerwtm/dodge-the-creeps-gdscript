extends Node

@export var mob_scene: PackedScene
var score: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$MobTimer.stop()
	$ScoreTimer.stop()

	$HUD.show_game_over_message()

	get_tree().call_group("mobs", "queue_free")


func new_game() -> void:
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

	$HUD.update_score(score)
	$HUD.show_message("Get Ready")


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_mob_timer_timeout() -> void:
	# 创建一个Mob Scene的实例
	var mob: RigidBody2D = mob_scene.instantiate()

	# 在Path2D中选择一个随机的位置
	var mob_spawn_position := $MobPath/MobSpawnLocation
	mob_spawn_position.progress_ratio = randf()

	# 将上面选择的位置赋值给Mob
	mob.position = mob_spawn_position.position

	# 设置一个随机的方向
	var direction: float = mob_spawn_position.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# 设置一个随机的初始速度
	var velocity = Vector2(randf_range(150.0, 200.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# 添加新的子结点到 Main Scene
	add_child(mob)
