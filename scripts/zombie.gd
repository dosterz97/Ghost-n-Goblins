extends CharacterBody2D

signal zombie_died(zombie)

const SPEED = 60.0
var direction = 0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("walk")
	pass # Replace with function body.
	
func spawn() -> void:
	animation_player.play("spawn")
	
func on_finished_spawn() ->  void:
	direction = 1
	animation_player.stop()
	animated_sprite.play("walk")
	print("on finished spawn")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func takeDamage() -> void:
	print("ZOMBIE: takeDamage")
	zombie_died.emit(self)
	queue_free()
	
