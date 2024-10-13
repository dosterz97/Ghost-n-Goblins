extends Area2D


const SPEED = 130
var direction = 1

@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	position.x += SPEED * delta * direction
	
	if direction > 0: 
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enemy_killzone_on_hit(projectile: Variant) -> void:
	print("YO YO YO")
	
	queue_free()
	pass # Replace with function body.
