extends MeshInstance3D
@onready var emotion = $Emotion
@onready var bt = $BTRunner
@onready var sound_ambient = $SoundAmbient
@onready var sound_threatened = $SoundThreatened

var last_emotion = -1

var current_colour := Color(0.0,1.0,1.0)
@onready var body_material: StandardMaterial3D = get_active_material(0)

var velocity := Vector3.ZERO
var max_speed := 3.0
var max_force := 2.0
var mass := 1.0
var wander_angle := 0.0
var pulse_time := 0.0
var show_debug := true




func _physics_process(delta: float) -> void:
	bt.tick()
	var cursor_pos = get_cursor_world_pos()
	emotion.update(delta, cursor_pos, global_position)
	
	var force := Vector3.ZERO
	
	match emotion.current:
		emotion.State.CURIOUS:
			force = orbit(cursor_pos)
		emotion.State.CONTENT:
			force = wander()
		emotion.State.THREATENED:
			force = flee(cursor_pos)
		emotion.State.LONELY:
			force = arrive(cursor_pos)
		emotion.State.SLEEPING:
			force = wander() * 0.1
			
	force = force.limit_length(max_force)
	var accel = force / mass
	velocity += accel * delta
	velocity = velocity.limit_length(max_speed)
	global_position += velocity * delta
	
	var pulse_speed := 2.0
	if emotion.current == emotion.State.SLEEPING:
		pulse_speed = 0.8
	if emotion.current == emotion.State.THREATENED:
		pulse_speed = 4.0
	
	pulse_time += delta * pulse_speed
	var pulse =1.0 + sin(pulse_time) * 0.08
	scale = Vector3.ONE * pulse
	
	var target_colour = get_emotion_colour()
	current_colour = current_colour.lerp(target_colour, delta * 2.0)
	body_material.emission = current_colour
	
	if emotion.current != last_emotion:
		last_emotion = emotion.current
		if emotion.current == emotion.State.THREATENED:
			sound_threatened.play()
		else:
			sound_threatened.stop()
			
	if show_debug:
		DebugDraw3D.draw_arrow(
			global_position,
			global_position + velocity,
			Color.YELLOW, 0.1
		)
		
		DebugDraw3D.draw_sphere(global_position, 0.1, Color.WHITE)
	
	
func orbit(target_pos:Vector3) -> Vector3:
	var orbit_radius := 3.0
	var orbit_speed := 1.5
	var angle = Time.get_ticks_msec() * 0.001 * orbit_speed
	var orbit_target = target_pos + Vector3(
		cos(angle) * orbit_radius,
		sin(angle) * orbit_radius * 0.3,
		0.0
		)
		
	return seek(orbit_target)
		
	
	
	
	
	

func seek(target_pos: Vector3) -> Vector3:
	var to_target = target_pos- global_position
	var desired = to_target.normalized() * max_speed
	return desired - velocity
	
func arrive(target_pos: Vector3) -> Vector3:
	var to_target = target_pos - global_position
	var distance = to_target.length()
	var slowing_distance := 3.0
	var ramped_speed = max_speed * (distance / slowing_distance)
	var clamped_speed = min(ramped_speed, max_speed)
	var desired = to_target.normalized() * clamped_speed
	return desired - velocity
	

	
	
	


func get_cursor_world_pos():
	var camera = get_viewport().get_camera_3d()
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_dir = camera.project_ray_normal(mouse_pos)
	var t = -ray_origin.z / ray_dir.z
	return ray_origin + ray_dir * t
	
	
	
func wander() -> Vector3:
	wander_angle += randf_range(-0.5, 0.5)
	var wander_direction = Vector3(
		cos(wander_angle),
		sin(wander_angle) * 0.3,
		0.0
	)
		
	return wander_direction * max_speed - velocity
	
	

func flee (target_pos: Vector3) -> Vector3:
	var to_target = target_pos - global_position
	var desired = -to_target.normalized() * max_speed
	return desired - velocity
	

func get_emotion_colour() -> Color:
	match emotion.current:
		emotion.State.CURIOUS:
			return Color(0.0, 1.0, 1.0)
		emotion.State.CONTENT:
			return Color(0.2, 0.4, 1.0)
		emotion.State.THREATENED:
			return Color(0.8, 0.0, 0.5)
		emotion.State.LONELY:
			return Color(0.8, 0.9, 1.0)
		emotion.State.SLEEPING:
			return Color(0.0, 0.5, 0.4)
	return Color(0.0,1.0,1.0)


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_G:
			show_debug = !show_debug
		 
			
	
	
	
	
