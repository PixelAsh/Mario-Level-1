extends Node2D


func _ready() -> void:
	$AnimationPlayer.play("cutscene")
	await get_tree().create_timer(1.6).timeout
	get_tree().change_scene_to_file("res://main.tscn")
