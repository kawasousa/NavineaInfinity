extends CharacterBody2D
class_name Player

@onready var camera = $Camera2D
@onready var sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
const SPEED = 30000
const RECOIL = -4000
var direction: Vector2 = Vector2.ZERO
var isCameraShaking: bool = false
var max_shoot = 4
const PRE_SHOOT = preload("res://scenes/entities/shoot.tscn")
var maxHitPoints: int = 4
var hitPoints: int = maxHitPoints

func _ready():
	Global.player = self

func _process(_delta):
	handledAnimation()
	if isCameraShaking:
		camera.offset = Vector2(randi_range(0, 4), randi_range(0, 4))

func _physics_process(delta):
	## Mantem a nave dentro dos limites da tela
	global_position.y = clamp(global_position.y, 40, 824)
	global_position.x = clamp(global_position.x, 40, 920)
	
	var _canMove = true
	var _canShoot = true
	
	if Global.game_over:
		_canMove = false
		_canShoot = false
		die()
	
	if _canMove:
		movement(delta)
	if _canShoot:
		shoot()
	updateHitPoints()

## Atirar
func shoot():
	if Input.is_action_just_pressed("shoot"):
		if get_tree().get_nodes_in_group("PlayerProjectiles").size() < max_shoot:
			var shoot_instance = PRE_SHOOT.instantiate()
			get_parent().get_node("shoot_group").add_child(shoot_instance)
			shoot_instance.global_position = Vector2(global_position.x + 56, global_position.y)
			shoot_instance.add_to_group("PlayerProjectiles")
			
			SoundManager.playSfx("shoot")

func play_damage_animation() -> void:
	animation_player.play("damage_animation")

## Movemento da nave
func movement(delta):
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	direction = direction.normalized()
	velocity = direction * SPEED * delta
	if direction.x == 0:
		velocity.x = RECOIL * delta
	move_and_slide()

func handledAnimation() -> void:
	match str(direction.y):
		"-1":
			sprite.play("going_up")
		"0":
			sprite.play("idle")
		"1":
			sprite.play("going_down")
	if direction == Vector2.RIGHT:
		sprite.set_frame(0)

func addHitPoints(points) -> void:
	hitPoints += points

func subtractHitPoints(points) -> void:
	hitPoints -= points
	if not Global.game_over:
		hurt()

func updateHitPoints() -> void:
	hitPoints = max(hitPoints, 0)
	if hitPoints == 0:
		Global.game_over = true

func hurt() -> void:
	SoundManager.playSfx("damage")
	play_damage_animation()
	isCameraShaking = true
	await get_tree().create_timer(0.5).timeout
	isCameraShaking = false

func die() -> void:
	isCameraShaking = false
	animated_sprite_2d.play("idle")
	rotate(0.001)
	global_position.x -= 0.5
