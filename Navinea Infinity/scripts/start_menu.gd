extends Control

@onready var start_button: Button = $MarginContainer/VBoxContainer/start
@onready var quit_button: Button = $MarginContainer/VBoxContainer/quit

func _ready() -> void:
	start_button.grab_focus()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
