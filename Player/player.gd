class_name Player
extends CharacterBody2D

@onready var gun1preload = preload("res://Player/Weapons/Gun1.tscn")
@onready var gun2preload = preload("res://Player/Weapons/Gun2.tscn")
# gunRotator seuraa hiirtä, jonka lapseksi ase lisätään, joten kun sitä vaihtaa, se osoittaa aina oikeaan suuntaan
@onready var gunRotator = get_node("Gunrotator")

var gunUsed
var gun1
var gun2 

# hakee hahmon, johon verrataan onko tarpeeksi lähellä
@onready var npc = get_node("../paavonpc")

@onready var collisionShape = get_node("CollisionShape2D")
@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D")
@onready var UI = get_node("UI")

var speed = 600
var health = 400
var maxHealth = health

# hoitaa liikkumisen
func _get_input():
	# jos peli ei pausella tai pelaaja kuollut
	if !UI.paused : 
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
	# lataa kummankin/niin monta kuin niitä halutaan heti alkuun skeneen
	gunRotator.add_child(gun1)
	gunRotator.add_child(gun2)
	# poistaa toisen aseen käytöstä
	gun2.set_process(false)
	gun2.visible = false
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
	gunUsed.visible = true
	gunUsed.set_process(true)

func _ready():
	Global.player = self
	UI.healthBar._init_bar(health)
	_init_gun()
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
func _physics_process(delta):
	move_and_slide()
	_get_input()
	#print(self.global_position)

	if health <= 0 :
		UI.deadText.visible = true
		UI.healthBar._set_health(0)
		UI.paused = true
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

	if Input.is_action_just_pressed("ui_select_gun1") and gunUsed != gun1 :
		_set_gun(1)
	if Input.is_action_just_pressed("ui_select_gun2") and gunUsed != gun2 :
		_set_gun(2)

func _readyy():
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
func _on_spawn(position: Vector2, direction: String):
	global_position = position
