extends Node3D

@export var segment_count := 8
@export var segment_length := 0.3

var segments: Array[Vector3] = []
var mesh_instance: ImmediateMesh
var mat: StandardMaterial3D

func _ready() -> void:
	for i in segment_count:
		segments.append(global_position)
	
	mesh_instance = ImmediateMesh.new()
	mat = StandardMaterial3D.new()
	mat.emission_enabled = true
	mat.emission = Color(0.0, 1.0, 1.0)
	mat.emission_energy_multiplier = 2.0
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	
	var mi = MeshInstance3D.new()
	mi.mesh = mesh_instance
	mi.material_override = mat
	add_child(mi)

func update_color(color: Color) -> void:
	mat.emission = color

func _physics_process(delta: float) -> void:
	segments[0] = global_position
	
	for i in range(1, segment_count):
		var to_prev = segments[i] - segments[i - 1]
		if to_prev.length() > segment_length:
			segments[i] = segments[i - 1] + to_prev.normalized() * segment_length
	
	mesh_instance.clear_surfaces()
	mesh_instance.surface_begin(Mesh.PRIMITIVE_LINE_STRIP)
	for seg in segments:
		mesh_instance.surface_add_vertex(to_local(seg))
	mesh_instance.surface_end()
