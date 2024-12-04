extends CharacterBody2D


@onready var player = Global.player
@onready var animation = $AnimatedSprite2D
#@onready var bloodAnim = $Bloodanimation
@onready var area2d = get_node("Area2D")
@onready var healthBar = get_node("Healthbar")

var entered : bool 
var speed : int # oli 100
var direction : Vector2
var collision
var enemies_dead = Global.main.get_node("enemyspawner").enemies_died
var health : float = 350

var damageToPlayer = 20

func _ready():
	var screen_rect = get_viewport_rect()
	direction = screen_rect.get_center() - global_position
	entered = false
	healthBar._init_bar(health)
	speed = randi_range(30, 60)
	get_node("Timer").start()

func _physics_process(delta):
	if entered:
		animation.play("walk")
		
		direction = (player.position - position).normalized()
		direction = direction.normalized()
		#velocity = (direction * speed)
		var velocity = (direction * speed)
		move_and_collide(direction * speed * delta)
		
		#kääntää animaation riippuen mobin kulkusuunnasta
		if direction.x < 0 : 
			animation.flip_h = true
		else : 
			animation.flip_h = false

	

func _on_timer_timeout():
	entered = true

func _on_area_2d_2_area_entered(area):
	if area.is_in_group("bullet") :
		# hakee damagen sen luodin skriptistä mikä siihen osui
		var gunDamage : float = area.get_parent().damage
		health = health - gunDamage
		healthBar._set_health(health)
		
		#print(area.global_position)
		#play_blood_animation(area.global_position)
		#
		if health <= 0 :
			get_node("Area2D/CollisionShape2D").queue_free() # poistaa hitboxin että luodit pääsee läpi
			get_node("Area2D2/CollisionShape2D").queue_free()
			self.set_physics_process(false)
			animation.play("die")
			await animation.animation_finished
			self.queue_free()
			enemies_dead.append(1)
			
func _on_area_2d_body_entered(body):
	if body == player:
		# niin kauan kun pelaaja on lähempänä kuin 100 jotain ?, toistaa lyömis animaatiota
		while area2d.global_position.distance_to(player.global_position) <= 100 :
			# kääntää mobin pelaajaa päin, muuten saataisi jäädä huitomaan väärään suuntaan
			if player.global_position.x - self.global_position.x < 0 :
				animation.flip_h = true
			else : 
				animation.flip_h = false
			
			self.set_physics_process(false)
			# varmaan tähän väliin se koodi, joka vahingoitta pelaajaa eli hit_player.emit() ??? ja siihen jotain muokkausta
			# suorittaa pelaajan skriptistä funktion joka vähentää siltä elämää
			# vois ehkä käyttää signaaleja mutta ei ne varmaa ois parempia 
			animation.play("attack")
			await animation.animation_finished
			self.set_physics_process(true)
