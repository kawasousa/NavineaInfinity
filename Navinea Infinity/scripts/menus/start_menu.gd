extends Control

@onready var start_button: Button = $MarginContainer/VBoxContainer/start

func _ready() -> void:
	start_button.grab_focus()
	Global.game_over = false

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
