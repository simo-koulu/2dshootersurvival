extends ProgressBar

@onready var healthBar = self
@onready var damageBar = get_node("Damagebar")
@onready var borderBar = get_node("Border")
@onready var timer = get_node("Timer")

var health : float 
var previousHealth : float 

func _init_bar(_health): 
	health = _health
	previousHealth = health
	healthBar.max_value = health
	damageBar.max_value = health
	borderBar.max_value = health
	healthBar.value = health
	damageBar.value = health
	
func _set_health(newHealth) : 
	health = newHealth
	
	if health <= 0 :
		healthBar.value = 0
	
	# jos on ottanut osumaa, aloittaa ajastimen
	if health < previousHealth : 
		timer.start()
	else : 
		damageBar.value = health
	# päivittää vihreän palkin kokoa heti kun luoti osuu 
	healthBar.value = health
	previousHealth = health
	
# tää päivittää ajastimen jälkeen valkosen palkin samankokoseksi kuin vihree palkki
func _on_timer_timeout() -> void:
	damageBar.value = health
