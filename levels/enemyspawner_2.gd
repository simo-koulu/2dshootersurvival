extends Node2D

var zombieScene : PackedScene
var skeletonScene : PackedScene

var timeBetweenWaves : float = 4.0
var spawnCoolDown : float = 1.0
var lastSpawned : bool = false

var spawned := 0
var spawnPoints := []

func _ready():
	self.set_process(false)

func _spawn_enemies():

	var enemiesPerWave = Global.export.room2BaseEnemies
	var zombies = Global.export.room2ZombiesPerSkeleton
	var zombiesSpawned = 0
	
	zombieScene = Global.export.zombieScene
	skeletonScene = Global.export.skeletonScene
	
	for i in get_children():
		if i is Marker2D:
			spawnPoints.append(i)

	await get_tree().create_timer(1).timeout
	
	# näin monta aaltoa tää spawnaa 
	for wave in Global.export.room1Waves :
		print("aalto   ", wave, "näin monta vihollista tällä aallolla   ", enemiesPerWave)
		
		#näin monta vihollista per aalto hakee numeron Exportvariables.gd 
		for mobs in enemiesPerWave :
			print ("mobeja  ", mobs, "aaalto   ", wave)
			
			if zombiesSpawned < zombies :
				_spawn_mob(spawnPoints[randi() % spawnPoints.size()], "zombie")
				zombiesSpawned = zombiesSpawned + 1
			elif zombiesSpawned == zombies : 
				_spawn_mob(spawnPoints[randi() % spawnPoints.size()], "skeleton")
				zombiesSpawned = 0
			
			#await get_tree().create_timer(spawnCoolDown).timeout
				
		#await get_tree().create_timer(timeBetweenWaves).timeout # odottaa hiukan ennen kuin aloittaa uuden aallon
		enemiesPerWave = round(enemiesPerWave + enemiesPerWave * 0.3) # lisää vihollisten määrää tällä kaavalla
		zombies = zombies - 1 #miinustaa yhden zombin jok spawnataan ennen luurankoa
	lastSpawned = true # sitku kaikki aallot ja viholliset menty läpi
	
func _spawn_mob(spawn : Marker2D, mob : String) :
	var enemy 
	
	match mob :
		"zombie" : 
			enemy = zombieScene.instantiate()
		"skeleton" :
			enemy = skeletonScene.instantiate()
		_:
			print("väärä vihollisen nimi", "  ", mob)
	
	enemy.global_position = spawn.global_position
	enemy.add_to_group("enemy")
	Global.main.add_child(enemy)
	print("spawnded   ", spawned)
	spawned = spawned + 1 
	
func _process(delta: float) -> void:
	
	# jos viiminenki viholline kentässä ja kaikki niistä kuollu, avaa seuraavan huoneen ja laittaa itsensä pois päält
	if get_tree().get_nodes_in_group("enemy").is_empty() and lastSpawned :
		Global.room2Cleared = true
		Global.player.get_node("UI")._room_cleared(2)
		self.set_process(false)
