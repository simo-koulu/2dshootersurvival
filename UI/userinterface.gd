extends Control

@onready var healthBar = get_node("CanvasLayer/Healthbar")
@onready var deadText = get_node("CanvasLayer/Deadlabel")
@onready var pauseMenu = get_node("CanvasLayer/Pause")
@onready var label = get_node("CanvasLayer/Label")
@onready var damageIndicator = get_node("CanvasLayer/Damageindicator")
@onready var button_animation = $CanvasLayer/Pause/Button/AnimatedSprite2D
@onready var clearedLabel = get_node("CanvasLayer/Roomcleared")

# laita UI sceneen
#pysäyttää pelin, laittaa PAUSE tekstin näkyviin
func _pause():
	if Global.paused == false:
		Engine.time_scale = 0
		pauseMenu.visible = true
		healthBar.visible = false
		Global.paused = !Global.paused
	elif Global.paused:
		Engine.time_scale = 1
		pauseMenu.visible = false
		healthBar.visible = true
		Global.paused = !Global.paused

func _take_damage():
	damageIndicator.modulate.a = 0.8
	var tween = damageIndicator.create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUART)
	tween.tween_property(damageIndicator, "modulate:a", 0, 0.1)


func _room_cleared(roomNumber):
	clearedLabel.text = str("Room ", roomNumber, " cleared")
	clearedLabel.modulate.a = 1
	
	var tween = clearedLabel.create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUART)
	tween.tween_property(clearedLabel, "modulate:a", 0, 5)

func _ready() -> void:
	
	deadText.visible = false
	pauseMenu.visible = false
	label.visible = false
	damageIndicator.modulate.a = 0
	clearedLabel.modulate.a = 0
	button_animation.play("no_hover")
	
func _physics_process(delta) :

	if Input.is_action_just_pressed("ui_cancel"):
		_pause()
	
	if Input.is_action_just_pressed("ui_focus_next"):
		get_tree().quit()
		


func _on_button_mouse_entered():
	button_animation.play("hover")


func _on_button_mouse_exited():
	button_animation.play("no_hover")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")
	Engine.time_scale = 1
	Global.paused = false
	

	
