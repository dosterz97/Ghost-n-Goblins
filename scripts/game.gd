extends Node2D

@onready var player: CharacterBody2D = $Player

var zombies = []

func _on_player_shoot(projectile: Variant, direction: Variant, location: Variant) -> void:
	print("onplayershoot")
	var spawned_projectile = projectile.instantiate()
	add_child(spawned_projectile)
	spawned_projectile.position = location
	spawned_projectile.direction = direction
	spawned_projectile.z_index = 1
	#spawned_projectile.velocity = velocity


var Zombie = preload("res://scenes/zombie.tscn")
var rng = RandomNumberGenerator.new()

func onZombieRemoved(zombie: Variant) -> void:
	print("onZombieRemoved", zombie)
	var index = zombies.find(zombie)
	
	if(index > -1):
		zombies.remove_at(index)


func _process(delta: float) -> void:
	if(zombies.size() < 2):
		var zombie = Zombie.instantiate()
		var offset = rng.randf_range(200, -200)
		zombie.position.x = offset
		zombie.position.y = 0
		zombie.z_index = 1
		zombie.zombie_died.connect(onZombieRemoved)
		
		print("GAME: " + str(zombie))
		add_child(zombie)
		
		zombie.spawn()
		zombies.append(zombie)
		
