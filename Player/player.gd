class_name Player
extends CharacterBody2D

@onready var gun1preload = preload("res://Player/Weapons/Gun1.tscn")
@onready var gun2preload = preload("res://Player/Weapons/Gun2.tscn")
@onready var gun3preload = preload("res://Player/Weapons/Gun3.tscn")
@onready var gun4preload = preload("res://Player/Weapons/Gun4.tscn")
# gunRotator seuraa hiirtä, jonka lapseksi ase lisätään, joten kun sitä vaihtaa, se osoittaa aina oikeaan suuntaan
@onready var gunRotator = get_node("Gunrotator")
@onready var camera = get_node("Camera")

var gunUsed
var gunIndex : int 
enum gunSelector { GUN0, GUN1, GUN2, GUN3 }
var gunList : Array = []

# hakee hahmon, johon verrataan onko tarpeeksi lähellä
@onready var npc = get_node("../paavonpc")
@onready var walking_sound = $AudioStreamPlayer2D
@onready var collisionShape = get_node("CollisionShape2D")
@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D")
@onready var UI = get_node("UI")

@onready var speed : int = Global.export.playerSpeed
@onready var health : int = Global.export.playerHealth
@onready var immortal : bool = Global.export.playerImmortal
var maxHealth

# hoitaa liikkumisen
func _get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	
	if velocity != Vector2.ZERO:
		anim.play('run')
		if !walking_sound.playing:
			walking_sound.pitch_scale = randf_range(0.8, 0.9)
			walking_sound.play()
	else: 
		anim.play('idle')

	if velocity.x < 0:
		anim.flip_h = true
	elif velocity.x > 0:
		anim.flip_h = false

# mobin skripti suorittaa tämän funktion joka kerta, ennen kun se tekee lyömis animaation
func _got_hit(damage) : 
	if !immortal : 
		if Global.camera.trauma <= 0.5 :
			Global.camera.add_trauma(0.6, 4)
		UI._take_damage()
		health = health - damage
		UI.healthBar._set_health(health)
		immortal = true
	else : pass
	await get_tree().create_timer(0.5).timeout
	immortal = false

func _init_gun():
	gunList.append(gun1preload.instantiate())
	gunList.append(gun2preload.instantiate())
	gunList.append(gun3preload.instantiate())
	gunList.append(gun4preload.instantiate())
	# ensimmäisenä ladattava ase / default 
	gunIndex = gunSelector.GUN0
	gunUsed = gunList[gunIndex]
	
	for gun in gunList :
		gunRotator.add_child(gun)
		
		if gun != gunUsed :
			gun.set_process(false)
			gun.visible = false
		else : pass

# vois todennäkösesti olla paljon kliinimpi mut nyt ei kiinnosta
func _set_gun():
	gunUsed.set_process(false)
	gunUsed.visible = false
	gunUsed = gunList[gunIndex]
	gunUsed.visible = true
	gunUsed.set_process(true)

func _ready() :
	maxHealth = health
	Global.player = self
	UI.healthBar._init_bar(health)
	_init_gun()
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
func _physics_process(_delta):
	
	if Input.is_action_just_pressed("ui_restart") : 
		print("restart")
		Global.paused = false
		Engine.time_scale = 1
		#get_tree().change_scene_to_file("res://levels/Main.tscn")
		get_tree().reload_current_scene()
		
	# jos peli ei pausella tai pelaaja kuollut
	if !Global.paused : 
		move_and_slide()
		_get_input()

		if health <= 0 :
			UI.deadText.visible = true
			UI.healthBar._set_health(0)
			Global.paused = true
			Engine.time_scale = 0

		# jos tarpeeksi lähellä jotain hahmoa, laita tekstipalikka näkyviin
		# tässä esimerkissä hahmo on paavo, hahmo pitää hakea erikseen get_nodella.
		var distance = collisionShape.global_position.distance_to(npc.global_position)
		if distance <= 150:
			UI.label.visible = true
		else :
			UI.label.visible = false
		
		# lataa elämät täyteen välilyönnistä
		if Input.is_action_just_pressed("ui_accept"):
			UI.healthBar._init_bar(maxHealth)
			health = maxHealth

		if Input.is_action_just_pressed("ui_select_gun1") and gunIndex != gunSelector.GUN0 :
			gunIndex = gunSelector.GUN0
			_set_gun()
		if Input.is_action_just_pressed("ui_select_gun2") and gunIndex != gunSelector.GUN1 :
			gunIndex = gunSelector.GUN1
			_set_gun()
		if Input.is_action_just_pressed("ui_select_gun3") and gunIndex != gunSelector.GUN2 :
			gunIndex = gunSelector.GUN2
			_set_gun()
		if Input.is_action_just_pressed("ui_select_gun4") and gunIndex != gunSelector.GUN3 :
			gunIndex = gunSelector.GUN3
			_set_gun()

		if Input.is_action_just_pressed("ui_zoom_in") :
			if camera.zoom.x <= 1.3 :
				camera.zoom.x = camera.zoom.x + 0.1
				camera.zoom.y = camera.zoom.y + 0.1
		if Input.is_action_just_pressed("ui_zoom_out") :
			if camera.zoom.x >= 0.6:
				camera.zoom.x = camera.zoom.x - 0.1
				camera.zoom.y = camera.zoom.y - 0.1
		
func _readyy():
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
func _on_spawn(position: Vector2, direction: String):
	global_position = position
