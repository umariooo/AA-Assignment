extends Node3D

@export var fish_count := 15
@export var separation_radius := 1.2
@export var neighbour_radius := 3.5
@export var separation_weight := 2.0
@export var alignment_weight := 1.0
@export var cohesion_weight := 1.0
@export var bounds := 8.0

var fish_list: Array = []

func _ready():
	print("FLOCK READY - spawning ", fish_count, " fish")
	var fish_script = load("res://fish.gd")
	var coral_model = load("res://koi_fish.glb")
	
	for i in fish_count:
		var fish = Node3D.new()
		fish.set_script(fish_script)
		add_child(fish)
		
		var model = coral_model.instantiate()
		model.scale = Vector3.ONE * 0.3
		fish.add_child(model)
		
		fish.position = Vector3(
		randf_range(-bounds, bounds),
		randf_range(0.5, 3.5),
		randf_range(-6.0, -2.0)
		)	
		fish_list.append(fish)

func _physics_process(delta):
	for fish in fish_list:
		var sep := Vector3.ZERO
		var align := Vector3.ZERO
		var coh := Vector3.ZERO
		var neighbours := 0

		for other in fish_list:
			if other == fish: continue
			var diff = fish.global_position - other.global_position
			var dist = diff.length()
			if dist < separation_radius and dist > 0.001:
				sep += diff.normalized() / dist
			if dist < neighbour_radius:
				align += other.velocity
				coh += other.global_position
				neighbours += 1

		var force := Vector3.ZERO
		force += sep * separation_weight
		if neighbours > 0:
			force += (align / neighbours - fish.velocity) * alignment_weight
			force += ((coh / neighbours) - fish.global_position) * cohesion_weight

		var p = fish.global_position
		if abs(p.x) > bounds: force.x -= sign(p.x) * 3.0
		if abs(p.z) > bounds * 0.5: force.z -= sign(p.z) * 3.0
		if p.y > 4.0: force.y -= 2.0
		if p.y < 0.3: force.y += 2.0

		fish.apply_force(force, delta)
