extends CanvasLayer

@onready var hit_points_label: Label = $hit_points
@onready var score_label: Label = $score
var score_draw: int = 0


func _process(_delta):
	update_hp_label()
	update_score_label()

func update_hp_label() -> void:
	hit_points_label.text = "vida: " + "<".repeat(Global.player.hitPoints)

func update_score_label() -> void:
	var increase_speed = max((Global.player_score - score_draw) / 20, 5)
	score_draw = move_toward(score_draw, Global.player_score, increase_speed)
	score_label.text = "score:" + str(score_draw)
