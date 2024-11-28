extends CharacterBody2D

@onready var area2d = get_node("Area2D")
@onready var timer = get_node("Bulletlife")
@onready var enemyDetector = get_node("Enemydetection")

var speed: int = 2000
var damage : float = 120
var enemyList := []
var lowestDistance = INF
var distance 
var target
var tracking = false

func initialize(pos):
	transform = pos

func _search_target() :
	print("searching")
	for mob in enemyList : 
		if mob != null :
			distance = self.global_position.distance_to(mob.global_position)
			print(distance)
			
			if distance < lowestDistance :
				lowestDistance = distance
				target = mob
	if target != null:
		_track_target()
	
func _track_target():
	area2d.monitorable = true
	enemyDetector.queue_free()
	look_at(target.global_position)
	tracking = true
	timer.start()

func _ready() -> void:
	get_node("Searchtimer").start()
	pass
	
func _physics_process(delta):
	if tracking :
		move_and_collide(transform.x * speed * delta)
		

func _on_timer_timeout() :
	queue_free()
	
func _on_searchtimer_timeout() -> void:
	if target == null :
		_search_target()

# jos osuu mobiin, tuhoaa itsensä
# voi lisätä sieiniä tai muita hahmoja jos siltä tuntuu 
# pitää vain lisätä sille hahmolle Area2D ja sille joku ryhmä
#func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.is_in_group("enemy"):
		#self.queue_free()


func _on_enemydetection_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") :
		print("vihollinen tuli alueelle ")
		enemyList.append(area)
