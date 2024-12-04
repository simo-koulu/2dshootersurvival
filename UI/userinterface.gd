extends Control

@onready var healthBar = get_node("CanvasLayer/Healthbar")
@onready var deadText = get_node("CanvasLayer/Deadlabel")
@onready var pauseMenu = get_node("CanvasLayer/Pause")
@onready var label = get_node("CanvasLayer/Label")
@onready var damageIndicator = get_node("CanvasLayer/Damageindicator")

var tookDamage = false 

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
	tookDamage = true

func _ready() -> void:
	deadText.visible = false
	pauseMenu.visible = false
	label.visible = false
	damageIndicator.modulate.a = 0

func _physics_process(delta) :
	if tookDamage :
		damageIndicator.modulate.a = lerp(damageIndicator.modulate.a, 0.0, 20 * delta)
		if damageIndicator.modulate.a <= 0 : 
			tookDamage = false
			
	if Input.is_action_just_pressed("ui_cancel"):
		_pause()
	
	if Input.is_action_just_pressed("ui_focus_next"):
		get_tree().quit()
		
