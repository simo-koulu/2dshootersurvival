extends CharacterBody2D

var speed: int = 1000

func initialize(pos):
	transform = pos

func _ready() -> void:
	pass
	
func _physics_process(delta):
	var collision = move_and_collide(transform.x * speed * delta)
	
	#tuhoaa itsensä jos osuu johonkin
	if collision :
		if collision.get_collider() is StaticBody2D or CollisionShape2D :
			self.queue_free()
