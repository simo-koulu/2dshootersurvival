extends Control

@onready var healthBar = get_node("CanvasLayer/Healthbar")
@onready var deadText = get_node("CanvasLayer/Deadlabel")
@onready var pauseMenu = get_node("CanvasLayer/Pause")
@onready var label = get_node("CanvasLayer/Label")

var paused = false

# laita UI sceneen
#pysäyttää pelin, laittaa PAUSE tekstin näkyviin
func _pause():
	if paused == false:
		Engine.time_scale = 0
		pauseMenu.visible = true
		healthBar.visible = false
		paused = !paused
	elif paused:
		Engine.time_scale = 1
		pauseMenu.visible = false
		healthBar.visible = true
		paused = !paused

func _ready() -> void:
	deadText.visible = false
	pauseMenu.visible = false
	label.visible = false

func _physics_process(delta) :
	if Input.is_action_just_pressed("ui_cancel"):
		_pause()
	
	if Input.is_action_just_pressed("ui_focus_next"):
		get_tree().quit()
