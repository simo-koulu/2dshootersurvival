extends CharacterBody2D

@onready var player = Global.main.get_node("Player")
@onready var animation = $AnimatedSprite2D

var entered : bool
#oli 100 
var speed = 100
var direction : Vector2

signal hit_player

func shot():
	self.queue_free()

func _on_PlayerBullet_body_entered(body):
	if body.has_method(shot):
		body.shot()
	queue_free()

func _ready():
	var screen_rect = get_viewport_rect()
	direction = screen_rect.get_center() - position
	entered = false
	
#kun mobi on kentän sisällä ja juoksu sen vähän aikaa nii sit se alkaa jahtaa pelaajaa
func _physics_process(delta):
	animation.play("run")
	if entered:
		direction = (player.position - position).normalized()
	direction = direction.normalized()
	#velocity = (direction * speed)
	var collision = move_and_collide(direction * speed * delta)
	
	if collision is KinematicCollision2D :
		self.queue_free()

	#kääntää animaation riippuen mobin kulkusuunnasta
	if direction.x < 0 : 
		animation.flip_h = true
	else : 
		animation.flip_h = false

func _on_entrancetimer_timeout():
	entered = true

func _on_area_2d_area_entered(area):
	hit_player.emit()
