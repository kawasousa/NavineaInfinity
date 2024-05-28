extends CanvasLayer

@onready var floating_animation: AnimationPlayer = $game_over_rect/floating_animation
@onready var restart: Button = $VBoxContainer/restart
@onready var high_score: Label = $high_score
@onready var high_score_user: LineEdit = $new_high_score/high_score_user
@onready var set_new_high_score_player: Button = $new_high_score/set_new_high_score_player
var button_focus_checker: bool = false
var new_hscore_setter: bool = false


func _ready():
	high_score_user.editable = false
	high_score_user.placeholder_text = Global.high_score_player

func _process(delta):
	show_game_over_screen()
	update_high_score_label()
	set_new_high_score()

## Se o botão de tentar novamente for clicado, a cena é reiniciada.
func _on_restart_pressed():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	visible = false
	Global.restart_game_values()

## Define as configurações da tela de game over
func show_game_over_screen() -> void:
	if Global.game_over:
		Engine.time_scale = 0.3
		visible = true
		grab_button_focus()
		Global.player_node.animated_sprite_2d.play("idle")
		Global.player_node.rotate(0.001)
		Global.player_node.global_position.x -= 0.5
		floating_animation.play("floating")

## Se o botão de sair for pressionado, a cena muda para o menu inicial
func _on_quit_to_menu_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")

## Define qual botão terá foco
func grab_button_focus() -> void:
	if Global.new_high_score == true:
		high_score_user.grab_focus()
		button_focus_checker = true
		if Input.is_action_just_pressed("ui_accept"):
			set_new_high_score_player.emit_signal("pressed")
	else:
		if button_focus_checker == false:
			restart.grab_focus()
			button_focus_checker = true

func update_high_score_label() -> void:
	high_score.text = "recorde: " + str(Global.high_score)

func set_new_high_score() -> void:
	if Global.new_high_score == true and new_hscore_setter == false:
		high_score_user.editable = true
		high_score_user.placeholder_text = "seu nome"
	else:
		high_score_user.editable = false
		set_new_high_score_player.disabled = true
		set_new_high_score_player.visible = false

func _on_set_new_high_score_player_pressed():
	Global.high_score_player = high_score_user.text
	Global.new_high_score = false
	new_hscore_setter = true
	button_focus_checker = false
