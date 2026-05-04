extends Node3D

var velocity := Vector3.ZERO
var max_speed := 2.5
var max_force := 1.5

func apply_force(force: Vector3, delta: float):
	velocity += force.limit_length(max_force) * delta
	velocity = velocity.limit_length(max_speed)
	global_position += velocity * delta
	if velocity.length() > 0.01:
		look_at(global_position + velocity, Vector3.UP)
