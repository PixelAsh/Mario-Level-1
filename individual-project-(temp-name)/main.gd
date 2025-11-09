extends Node


func _ready():
	while $Player.health > 0:
		await get_tree().create_timer(.1).timeout
		$UI/HBoxContainer/HealthLabel.text = str($Player.health)
		if $UI/HBoxContainer/HealthLabel.text <= "0":
			$UI/HBoxContainer/HealthLabel.text = "0"


func _on_player_player_dead() -> void:
	game_over()
	$Camera2D.enabled = true

func game_over():
	$UI/CenterContainer/Gameover.visible = true
	$UI/HBoxContainer/HealthLabel.visible = false
	$Player.queue_free()

func _on_end_trigger_body_entered(_body: CharacterBody2D):
	$UI/HBoxContainer/HealthLabel.visible = false
	get_tree().change_scene_to_file("res://cutscene_2.tscn")
