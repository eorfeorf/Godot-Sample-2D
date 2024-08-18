extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#new_game()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	pass
	
func new_game() -> void:
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	pass


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	pass # Replace with function body.


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)
	pass # Replace with function body.


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	var mob_spawn_locatioin = $MobPath/MobSpawnLocation
	mob_spawn_locatioin.progress_ratio = randf()
	
	var direction = mob_spawn_locatioin.rotation + PI / 2
	
	mob.position = mob_spawn_locatioin.position
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
	pass # Replace with function body.
