extends CharacterBody2D

@onready var area2d = get_node("Area2D")
@onready var flightTimer = get_node("Flighttimer")
@onready var bulletLife = get_node("Bulletlife")
@onready var searchTimer = get_node("Searchtimer")
@onready var enemyDetector = get_node("Enemydetection")
@onready var anim = get_node("Animation")
@onready var animPlayer = get_node("AnimationPlayer")

var velocit = Vector2.ZERO
var acceleration : int = 400
var speed: int = 2000
var damage : float = 100
var enemyList := []
var lowestDistance = INF
var distance 
var target
var tracking = false

func initialize(pos):
	global_position = pos

func _search_target() :
	#print("searching")
	for mob in enemyList : 
		if mob != null :
			distance = self.global_position.distance_to(mob.global_position)
			
			if distance < lowestDistance :
				lowestDistance = distance
				target = mob
				
	if target != null:
		_track_target()
	
func _track_target():
	#animPlayer.play("enemyfound")
	#await animPlayer.animation_finished
	animPlayer.play("attack")
	await animPlayer.animation_finished
	
	if target == null :
		_search_target()
	elif target != null : 
		look_at(target.global_position)
		enemyDetector.queue_free()
		area2d.monitorable = true
		tracking = true
		flightTimer.start()

func _ready() -> void:	
	searchTimer.start()
	bulletLife.start()
	anim.play("default")
	
func _physics_process(delta):
	
	if velocity.x < 0:
		anim.flip_v = true
	elif velocity.x > 0:
		anim.flip_v = false
	
	if tracking :
		var acceleration_vector = global_transform.x * acceleration * delta
		velocity += acceleration_vector
		velocity = velocity.limit_length(speed)
		move_and_collide(velocity)
		#move_and_collide(transform.x * speed * delta)

func _on_flighttimer_timeout() :
	queue_free()
	
func _on_bulletlife_timeout() :
	queue_free()
	
func _on_searchtimer_timeout() -> void:
	if target == null :
		_search_target()

func _on_enemydetection_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") :
		enemyList.append(area)
