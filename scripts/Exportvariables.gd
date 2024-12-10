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

@export var mobDamage1 : Array = [20, 40]
@export var mobHealth1 : Array = [180, 250]
@export var mobSpeed1 : Array = [[80, 120], [70, 110]]


@export_group("Room2")
@export var waves2 : int = 3
@export var baseEnemies2 : int = 10
@export var zombiesPerSkeleton2 : int = 6

@export var timeBetweenWaves2 : float = 4.0
@export var spawnCoolDown2 : float = 1.0

@export var mobDamage2 : Array = [20, 40]
@export var mobHealth2 : Array = [180, 250]
@export var mobSpeed2 : Array = [[80, 120], [70, 110]]


@export_group("Room3")
@export var waves3 : int = 3
@export var baseEnemies3 : int = 10
@export var zombiesPerSkeleton3 : int = 6

@export var timeBetweenWaves3 : float = 4.0
@export var spawnCoolDown3 : float = 1.0

@export var mobDamage3 : Array = [20, 40]
@export var mobHealth3 : Array = [180, 250]
@export var mobSpeed3 : Array = [[80, 120], [70, 110]]


@export_group("Room4")
@export var waves4 : int = 3
@export var baseEnemies4 : int = 10
@export var zombiesPerSkeleton4 : int = 6

@export var timeBetweenWaves4 : float = 4.0
@export var spawnCoolDown4 : float = 1.0

@export var mobDamage4 : Array = [20, 40]
@export var mobHealth4 : Array = [180, 250]
@export var mobSpeed4 : Array = [[80, 120], [70, 110]]


@export_group("Room5")
@export var waves5 : int = 3
@export var baseEnemies5 : int = 10
@export var zombiesPerSkeleton5 : int = 6

@export var timeBetweenWaves5 : float = 4.0
@export var spawnCoolDown5 : float = 1.0

@export var mobDamage5 : Array = [20, 40]
@export var mobHealth5 : Array = [180, 250]
@export var mobSpeed5 : Array = [[80, 120], [70, 110]]


@export_group("Room6")
@export var waves6 : int = 3
@export var baseEnemies6 : int = 10
@export var zombiesPerSkeleton6 : int = 6

@export var timeBetweenWaves6 : float = 4.0
@export var spawnCoolDown6 : float = 1.0

@export var mobDamage6 : Array = [20, 40]
@export var mobHealth6 : Array = [180, 250]
@export var mobSpeed6 : Array = [[80, 120], [70, 110]]


@export_group("Room7")
@export var waves7 : int = 3
@export var baseEnemies7 : int = 10
@export var zombiesPerSkeleton7 : int = 6

@export var timeBetweenWaves7 : float = 4.0
@export var spawnCoolDown7 : float = 1.0

@export var mobDamage7 : Array = [20, 40]
@export var mobHealth7 : Array = [180, 250]
@export var mobSpeed7 : Array = [[80, 120], [70, 110]]


@export_group("Room8")
@export var waves8 : int = 3
@export var baseEnemies8 : int = 10
@export var zombiesPerSkeleton8 : int = 6

@export var timeBetweenWaves8 : float = 4.0
@export var spawnCoolDown8 : float = 1.0

@export var mobDamage8 : Array = [20, 40]
@export var mobHealth8 : Array = [180, 250]
@export var mobSpeed8 : Array = [[80, 120], [70, 110]]
