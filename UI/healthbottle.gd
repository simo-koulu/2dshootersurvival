extends Node2D

var player
var healthGain = 80

func _ready() -> void:
	player = Global.player
	get_node("AnimatedSprite2D").play("default")

func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) :
	if body == player : 
		player._gain_health(healthGain)
		queue_free()
