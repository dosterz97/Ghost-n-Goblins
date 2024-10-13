extends Area2D

signal onHit(enemy)

func _on_body_entered(body: Node2D) -> void:
	print("ENEMY KILLZONE")
	onHit.emit(body)
	
	if body.has_method("takeDamage"):
		body.takeDamage()
