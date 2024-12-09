extends Node2D
@onready var button_sound = $AudioStreamPlayer2D
@onready var play_animation = $Button/AnimatedSprite2D
@onready var frame2 = "res://assets/Buttons Pixel Animation Pack/play/343px/play02.png"
@onready var hovering : bool = true
var mainmenureload : bool = false

@onready var playeranim = $player
@onready var zombieanim = $CanvasModulate2/MorningLayer3/zombie

@export var main_scene : PackedScene

@onready var nimi : Sprite2D = $"CanvasModulate2/2d-eeppinen-shooter-zombie-su-6-12-2024"

func _ready():
	$AudioStreamPlayer2D2.play()
	zombieanim.play("default")
	playeranim.play("default")
	nimi.scale = Vector2(1, 1)  # Initial scale
	
func _on_button_mouse_entered():
	if hovering:
		play_animation.play("hover")
	else:
		play_animation.stop()

func _on_button_mouse_exited():
	play_animation.play("no_hover")

func _on_button_pressed():
	hovering = false
	button_sound.play()
	play_animation.play("play2")
	await button_sound.finished
	get_tree().change_scene_to_packed(main_scene)
	hovering = true
	Global.paused = false
	Engine.time_scale = 1


var scale_speed = 1.1
var scale_factor = 0.05
var timer = 0.0

func _process(delta):
	timer += delta * scale_speed
	var scale_value = 1.0 + scale_factor * sin(timer)
	nimi.scale = Vector2(scale_value, scale_value)

	if Input.is_action_just_pressed("ui_focus_next"):
		get_tree().quit()
