extends CharacterBody2D

@onready var player = Global.player
@onready var animation = $AnimatedSprite2D
@onready var bloodAnim = $Bloodanimation
@onready var area2d = get_node("Area2D")
@onready var healthBar = get_node("Healthbar")

var entered : bool 
var speed : int # oli 100
var direction : Vector2
var collision
var enemies_dead = Global.main.get_node("enemyspawner").enemies_died
var health : float = 150

var damageToPlayer = 20

#signal hit_player

func play_blood_animation (location) :
	bloodAnim.position = location
	bloodAnim.visible = true
	bloodAnim.play("hit")
	await bloodAnim.animation_finished
	bloodAnim.visible = false
	
func _ready():
	var screen_rect = get_viewport_rect()
	direction = screen_rect.get_center() - position
	entered = false
	healthBar._init_bar(health)
	speed = randi_range(90, 110)

#kun mobi on kentän sisällä ja juoksu sen vähän aikaa nii sit se alkaa jahtaa pelaajaa
func _physics_process(delta):
	animation.play("run")
	if entered:
		direction = (player.position - position).normalized()
	direction = direction.normalized()
	#velocity = (direction * speed)
	collision = move_and_collide(direction * speed * delta)
	
	#kääntää animaation riippuen mobin kulkusuunnasta
	if direction.x < 0 : 
		animation.flip_h = true
	else : 
		animation.flip_h = false

func _on_entrancetimer_timeout():
	entered = true

func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet") :
		# hakee damagen sen luodin skriptistä mikä siihen osui
		var gunDamage : float = area.get_parent().damage
		health = health - gunDamage
		healthBar._set_health(health)
		
		#print(area.global_position)
		#play_blood_animation(area.global_position)
		#
		if health <= 0 :
			get_node("Area2D/CollisionShape2D2").queue_free() # poistaa hitboxin että luodit pääsee läpi
			self.set_physics_process(false)
			animation.play("die")
			await animation.animation_finished
			self.queue_free()
			enemies_dead.append(1)
	# hit_player.emit() # ehkä täs kohtaa turha, vois muokata ja siirtää alla olevaan kohtaan ennen hyökkäysanimatiota 
	
#Kun pelaaja osuu viholliseen ni se triggeröi lyöntianimaation ja pysähtyy
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
			player._got_hit(damageToPlayer)
			animation.play("attack")
			await animation.animation_finished
			self.set_physics_process(true)
