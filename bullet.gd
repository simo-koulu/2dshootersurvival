extends CharacterBody2D
class_name Bullet

var speed: int = 1500

func initialize(pos):
	transform = pos

func _ready() -> void:
	get_node("Timer").start()
	get_node("Timer").timeout.connect(_on_timer_timeout)
	
func _physics_process(delta):
	var collision = move_and_collide(transform.x * speed * delta)
	
	#tuhoaa itsensä jos osuu johonkin
	if collision :
		if collision.get_collider() is StaticBody2D or CollisionShape2D :
			self.queue_free()

func _on_timer_timeout() :
	queue_free()
