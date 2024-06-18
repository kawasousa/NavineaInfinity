extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
var max_shoot = 4
const SPEED = 30000
const RECOIL = -4000
const PRE_SHOOT = preload("res://scenes/shoot.tscn")

func _ready():
	Global.player_node = self

func _physics_process(delta):
	## Mantem a nave dentro dos limites da tela
	global_position.y = clamp(global_position.y, 40, 824)
	global_position.x = clamp(global_position.x, 40, 920)
	
	var _canMove = true
	var _canShoot = true
	
	if Global.game_over:
		_canMove = false
		_canShoot = false
	
	if _canMove:
		movement(delta)
	if _canShoot:
		shoot()

## Atirar
func shoot():
	if Input.is_action_just_pressed("shoot"):
		if get_tree().get_nodes_in_group("PlayerProjectiles").size() < max_shoot:
			var shoot_instance = PRE_SHOOT.instantiate()
			get_parent().get_node("shoot_group").add_child(shoot_instance)
			shoot_instance.global_position = Vector2(global_position.x + 56, global_position.y)
			shoot_instance.add_to_group("PlayerProjectiles")

func play_damage_animation() -> void:
	animation_player.play("damage_animation")

## Movemento da nave
func movement(delta):
	var directionY = Input.get_axis("ui_up", "ui_down")
	var directionX = Input.get_axis("ui_left", "ui_right")
	
	if directionY > 0:
		velocity.y = SPEED * directionY * delta
		sprite.play("going_down")
	elif directionY < 0:
		velocity.y = SPEED * directionY * delta
		sprite.play("going_up")
	else:
		velocity.y = 0
		sprite.play("idle")
	
	if directionX != 0:
		velocity.x = directionX * delta * SPEED
	else:
		## Se o player não se movimentar, a nave terá um recuo automático para a esquerda
		velocity.x = RECOIL * delta
		
	move_and_slide()
