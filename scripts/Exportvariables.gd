# skripti josta suurin osa pelin komponenteista ottaa muuttujansa 
# esim. pelaajan nopeus, aseiden damage, tulinopeus jne. jne.
# ne on täällä että niitä voi helposti muokata Exportvariables noden inspectorista
# voi lisätä muitakin kuten aaltojen vihollisten määrä tai tulevien mobien damage, nopeus

@tool
extends Node2D

func _ready() -> void:
	Global.export = self

@export_group("scenes")
@export var healthBottleScene : PackedScene = null
@export var zombieScene : PackedScene = null
@export var skeletonScene : PackedScene = null

@export_group("Player")
@export var playerSpeed : int = 600
@export var playerHealth : int = 400 
@export var playerImmortal : bool = false

@export_group("Zombie")
@export var zombieHealth : int = 180
@export var zombieDamage : int = 20
@export var zombieSpeed : Array = [80, 120] # valitsee zombin nopeuden näiden kahden arvon väliltä

@export_group("Gun1")
@export var gun1Firerate : float = 700
@export var gun1BulletDamage : int = 14
@export var gun1BulletSpeed :int = 1500

@export_group("Gun2")
@export var gun2FireRate : float = 60
@export var gun2BulletDamage : int = 130
@export var gun2BulletSpeed : int = 3400
@export var gun2BulletAcceleration : int = 400

@export_group("Gun3")
@export var gun3FireRate : float = 500
@export var gun3BulletDamage : int = 1000

@export_group("Gun4")
@export var gun4FireRate : float = 80
@export var gun4BulletDamage : int = 40
@export var gun4BulletSpeed : Array = [1800, 2300]
@export var gun4Spread : int = 35
@export var gun4SpreadRandomness : float = 7
@export var gun4Pellets : int = 5
@export var gun4PelletDecay : float = 0.002

@export_group("Room1")
@export var waves1 : int = 3
@export var baseEnemies1 : int = 10
@export var zombiesPerSkeleton1 : int = 6

@export var timeBetweenWaves1 : float = 4.0
@export var spawnCoolDown1 : float = 1.0

@export var room1ZombieDamage : int = 20
@export var room1ZombieHealth : int = 180
@export var room1ZombieSpeed : Array = [80, 120]

@export_group("Room2")
@export var waves2 : int = 3
@export var baseEnemies2 : int = 10
@export var zombiesPerSkeleton2 : int = 6

@export var timeBetweenWaves2 : float = 4.0
@export var spawnCoolDown2 : float = 1.0

@export var zombieDamage2 : int = 20
@export var zombieHealth2 : int = 180
@export var zombieSpeed2 : Array = [80, 120]

@export_group("Room3")
@export var waves3 : int = 3
@export var baseEnemies3 : int = 10
@export var zombiesPerSkeleton3 : int = 6

@export var timeBetweenWaves3 : float = 4.0
@export var spawnCoolDown3 : float = 1.0

@export var zombieDamage3 : int = 20
@export var zombieHealth3 : int = 180
@export var zombieSpeed3 : Array = [80, 120]
