extends CharacterBody2D

var speed: int = 1000

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

# tuhoaa luodin 3s jälkeen, käyttäen Timer-nodea
func _on_timer_timeout():
	self.queue_free()
