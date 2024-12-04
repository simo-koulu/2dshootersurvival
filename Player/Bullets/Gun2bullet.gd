extends CharacterBody2D

@onready var area2d = get_node("Area2D")
@onready var flightTimer = get_node("Flighttimer")
@onready var bulletLife = get_node("Bulletlife")
@onready var searchTimer = get_node("Searchtimer")
@onready var enemyDetector = get_node("Enemydetection")
@onready var anim = get_node("Animation")
@onready var animPlayer = get_node("AnimationPlayer")
@onready var particles = get_node("GPUParticles2D")

var gun2Acceleration : int = Global.export.gun2BulletAcceleration
var gun2Speed : int = Global.export.gun2BulletSpeed
var damage : int = Global.export.gun2BulletDamage
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
		particles.emitting = true
		if Global.camera.trauma <= 75.0 / 100.0 :
			Global.camera.add_trauma(50, 0.6)

func _ready() -> void:	
	searchTimer.start()
	bulletLife.start()
	anim.play("default")
	particles.emitting = false
	velocity = Vector2.ZERO
	
func _physics_process(delta):
	
	if velocity.x < 0:
		anim.flip_v = true
	elif velocity.x > 0:
		anim.flip_v = false
	
	if tracking :
		var acceleration_vector = global_transform.x * gun2Acceleration * delta
		velocity += acceleration_vector
		velocity = velocity.limit_length(gun2Speed)
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
