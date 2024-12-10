extends Camera2D

var decay := 0.8 #How quickly shaking will stop [0,1].
@export var maxOffset := Vector2(100,75) #Maximum displacement in pixels.
@export var maxRoll = 0.0 #Maximum rotation in radians (use sparingly).
@export var noise : FastNoiseLite #The source of random values.

var noiseY = 0 #Value used to move through the noise

var trauma := 0.0 #Current shake strength
var traumaPower := 3 #Trauma exponent. Use [2,3]

func _ready():
	Global.camera = self 
	randomize()
	noise.seed = randi()

func add_trauma(amount : float, decay : float):
	#trauma = min(trauma + amount / 100, 1.0)
	trauma = amount / 100
	decay = decay / 100
	
func shake(): 
	var amount = pow(trauma, traumaPower)
	noiseY += 1
	rotation = maxRoll * amount * noise.get_noise_2d(0, noiseY)
	offset.x = maxOffset.x * amount * noise.get_noise_2d(1000, noiseY)
	offset.y = maxOffset.y * amount * noise.get_noise_2d(2000, noiseY)
	
func _process(delta):
	#if trauma > 0 :
		#print(trauma)
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake() #optional
	elif offset.x != 0 or offset.y != 0 or rotation != 0:
		lerp(offset.x, 0.0, 1)
		lerp(offset.y, 0.0, 1)
		lerp(rotation, 0.0, 1)
