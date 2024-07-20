extends CanvasLayer

@onready var h_box_container = $tutorial/HBoxContainer
@onready var w = $tutorial/HBoxContainer/w
@onready var a = $tutorial/HBoxContainer/a
@onready var s = $tutorial/HBoxContainer/s
@onready var d = $tutorial/HBoxContainer/d
@onready var k = $tutorial/HBoxContainer/k
@onready var animation_player = $AnimationPlayer
var pressed_keys: int = 0

func _ready():
	animation_player.play("slide")

func _process(_delta):
	if Input.is_action_just_pressed("ui_up"):
		w.visible = false
		pressed_keys += 1
	elif Input.is_action_just_pressed("ui_left"):
		a.visible = false
		pressed_keys += 1
	elif Input.is_action_just_pressed("ui_down"):
		s.visible = false
		pressed_keys += 1
	elif Input.is_action_just_pressed("ui_right"):
		d.visible = false
		pressed_keys += 1
	elif Input.is_action_just_pressed("shoot"):
		k.visible = false
		pressed_keys += 1
	
	if pressed_keys == 5:
		visible = false
		Global.level.can_spawn_enemies = true
