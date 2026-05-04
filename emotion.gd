extends Node

enum State {CURIOUS, CONTENT, THREATENED, LONELY, SLEEPING}

var current := State.CONTENT

var mouse_speed := 0.0
var last_mouse_pos := Vector2.ZERO
var time_since_mouse_moved := 0.0
var time_cursor_far := 0.0

@export var cursor_far_threshold := 6.0
@export var mouse_fast_threshold := 400.0
@export var sleep_threshold := 5.0
@export var lonely_threshold := 3.0


func update(delta: float, cursor_world_pos: Vector3, nyra_pos : Vector3) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	mouse_speed = (mouse_pos - last_mouse_pos).length() / delta
	last_mouse_pos = mouse_pos

	var distance = nyra_pos.distance_to(cursor_world_pos)
	
	if mouse_speed < 10.0:
		time_since_mouse_moved += delta
	else:
		time_since_mouse_moved = 0.0
	
	if distance > cursor_far_threshold:
		time_cursor_far += delta
	else:
		time_cursor_far = 0.0
	
	
	if mouse_speed > mouse_fast_threshold:
		current = State.THREATENED
	elif time_since_mouse_moved > sleep_threshold:
		current = State.SLEEPING
	elif time_cursor_far > lonely_threshold:
		current = State.LONELY
	elif distance < cursor_far_threshold:
		current = State.CURIOUS
	else:
		current = State.CONTENT
		
	
