class_name Player
extends CharacterBody2D

@onready var gun1preload = preload("res://Player/Weapons/Gun1.tscn")
@onready var gun2preload = preload("res://Player/Weapons/Gun2.tscn")
@onready var gun3preload = preload("res://Player/Weapons/Gun3.tscn")
# gunRotator seuraa hiirtä, jonka lapseksi ase lisätään, joten kun sitä vaihtaa, se osoittaa aina oikeaan suuntaan
@onready var gunRotator = get_node("Gunrotator")
@onready var camera = get_node("Camera")

var gunUsed
var gun1
var gun2 
var gun3

# hakee hahmon, johon verrataan onko tarpeeksi lähellä
@onready var npc = get_node("../paavonpc")

@onready var collisionShape = get_node("CollisionShape2D")
@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D")
@onready var UI = get_node("Camera/UI")

var speed = 600
var health = 400
var maxHealth = health

# hoitaa liikkumisen
func _get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	
	if velocity != Vector2.ZERO:
		anim.play('run')
	else: 
		anim.play('idle')

	if velocity.x < 0:
		anim.flip_h = true
	elif velocity.x > 0:
		anim.flip_h = false

# mobin skripti suorittaa tämän funktion joka kerta, ennen kun se tekee lyömis animaation
func _got_hit(damage) : 
	health = health - damage
	UI.healthBar._set_health(health)

func _init_gun():
	gun1 = gun1preload.instantiate()
	gun2 = gun2preload.instantiate()
	gun3 = gun3preload.instantiate()
	# lataa kummankin/niin monta kuin niitä halutaan heti alkuun skeneen
	gunRotator.add_child(gun1)
	gunRotator.add_child(gun2)
	gunRotator.add_child(gun3)
	# poistaa muut aseet käytöstä
	gun2.set_process(false)
	gun2.visible = false
	gun3.set_process(false)
	gun3.visible = false
	gunUsed = gun1 

# vois todennäkösesti olla paljon kliinimpi mut nyt ei kiinnosta
# pitää myös tehdä joku korjaus että ase ei pysyy siinä kohtaa missä hiiri on eikä aloita joka kerta oletus sijainnista
func _set_gun(gun):
	gunUsed.set_process(false)
	gunUsed.visible = false
	if gun == 1 :
		gunUsed = gun1
	elif gun == 2 : 
		gunUsed = gun2
	elif gun == 3 :
		gunUsed = gun3
	gunUsed.visible = true
	gunUsed.set_process(true)

func _ready():
	Global.player = self
	UI.healthBar._init_bar(health)
	_init_gun()
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
func _physics_process(delta):
	# jos peli ei pausella tai pelaaja kuollut
	if !Global.paused : 
		move_and_slide()
		_get_input()
		#print(self.global_position)

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
		
		if Input.is_action_just_pressed("ui_restart") : 
			Global.paused = false
			Engine.time_scale = 1
			get_tree().change_scene_to_file("res://levels/Main.tscn")

		if Input.is_action_just_pressed("ui_select_gun1") and gunUsed != gun1 :
			_set_gun(1)
		if Input.is_action_just_pressed("ui_select_gun2") and gunUsed != gun2 :
			_set_gun(2)
		if Input.is_action_just_pressed("ui_select_gun3") and gunUsed != gun3 :
			_set_gun(3)

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
