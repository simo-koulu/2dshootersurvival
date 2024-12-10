extends Node2D
class_name Spawner

@export var roomNumber : int 

@onready var spawnLine : Line2D = get_node("Spawnline")

var zombieScene : PackedScene
var skeletonScene : PackedScene

var lastSpawned : bool = false

var zombiesSpawned = 0
var spawned := 0
var spawnPoints := []

func _ready():
	self.set_process(false)

func _get_random_point(line: Line2D) -> Vector2:
	var points = line.points
	
	if points.size() < 2:
		return Vector2.ZERO
		
	var totalLength = 0.0
	var segmentLengths = []
	
	# Calculate the length of each segment and the total length
	for i in range(points.size() - 1):
		var segmentLength = points[i].distance_to(points[i + 1])
		segmentLengths.append(segmentLength)
		totalLength += segmentLength
	
	# Choose a random point along the total length
	var randomLength = randf() * totalLength
	
	# Find which segment the random point falls into
	var accumulatedLength = 0.0
	for i in range(segmentLengths.size()):
		
		if accumulatedLength + segmentLengths[i] >= randomLength:
			
			var segmentStart = points[i]
			var segmentEnd = points[i + 1]
			var segmentFraction = (randomLength - accumulatedLength) / segmentLengths[i]
			return segmentStart.lerp(segmentEnd, segmentFraction)
			
		accumulatedLength += segmentLengths[i]

	return points[0]  # Fallback in case of an error
	
func _spawn_enemies():
	var waves = Global.export.get("waves" + str(roomNumber))

	var enemiesPerWave = Global.export.get("baseEnemies" + str(roomNumber))
	var zombies = Global.export.get("zombiesPerSkeleton" + str(roomNumber))
	
	var timeBetweenWaves = Global.export.get("timeBetweenWaves" + str(roomNumber))
	var spawnCoolDown = Global.export.get("spawnCoolDown" + str(roomNumber))
	
	zombieScene = Global.export.zombieScene
	skeletonScene = Global.export.skeletonScene
	
	var maxMobs = enemiesPerWave * 1.75

	await get_tree().create_timer(1).timeout
	
	# näin monta aaltoa tää spawnaa 
	for wave in waves :
		
		#näin monta vihollista per aalto hakee numeron Exportvariables.gd 
		for mobs in enemiesPerWave :
			var spawnPoint = _get_random_point(spawnLine)
			if zombiesSpawned < zombies :
				#_spawn_mob(spawnPoints[randi() % spawnPoints.size()], "zombie")
				_spawn_mob(spawnPoint, "zombie")
				zombiesSpawned = zombiesSpawned + 1
			elif zombiesSpawned == zombies : 
				#_spawn_mob(spawnPoints[randi() % spawnPoints.size()], "skeleton")
				_spawn_mob(spawnPoint, "skeleton")
				zombiesSpawned = 0
			await get_tree().create_timer(spawnCoolDown).timeout
				
		await get_tree().create_timer(timeBetweenWaves).timeout # odottaa hiukan ennen kuin aloittaa uuden aallon
		if enemiesPerWave <= maxMobs : # rajottaa aaltojen mobimäärän ettei niit tuu nii saatanasti 
			enemiesPerWave = round(enemiesPerWave + enemiesPerWave * 0.3) # lisää vihollisten määrää tällä kaavalla
		else : pass
		# zombies = zombies - 1 #miinustaa yhden zombin jok spawnataan ennen luurankoa
	lastSpawned = true # sitku kaikki aallot menty läpi ja kaikki viholliset spawnattu
	
func _spawn_mob(spawn : Vector2, mob : String) :
	
	var mobDamage = Global.export.get("mobDamage" + str(roomNumber))
	var mobHealth = Global.export.get("mobHealth" + str(roomNumber))
	var mobSpeed = Global.export.get("mobSpeed" + str(roomNumber))
	
	var enemy 
	var mobIndex : int
	
	match mob :
		"zombie" : 
			enemy = zombieScene.instantiate()
			mobIndex = 0
		"skeleton" :
			enemy = skeletonScene.instantiate()
			mobIndex = 1 
		_:
			print("väärä vihollisen nimi", "  ", mob)
	
	enemy.health = mobHealth[mobIndex]
	enemy.damage = mobDamage[mobIndex]
	enemy.speed = randi_range(mobSpeed[mobIndex][0], mobSpeed[mobIndex][1])
	
	enemy.position = spawn
	enemy.add_to_group("enemy")
	self.add_child(enemy)
	print("spawnded   ", spawned)
	spawned = spawned + 1 
	
func _process(delta: float) -> void:
	
	# jos viiminenki viholline kentässä ja kaikki niistä kuollu, avaa seuraavan huoneen ja laittaa itsensä pois päält
	if get_tree().get_nodes_in_group("enemy").is_empty() and lastSpawned :
		if roomNumber == 2 :
			Global.gun2Unlocked = true
			Global.player.get_node("UI")._info_text("New gun unlocked ! press 2")
		elif roomNumber == 5 :
			Global.gun3Unlocked = true
			Global.player.get_node("UI")._info_text("New gun unlocked ! press 3")
		else : pass
		Global.set("room" + str(roomNumber) + "Cleared", true)
		Global.player.get_node("UI")._room_cleared(roomNumber)
		self.set_process(false)
