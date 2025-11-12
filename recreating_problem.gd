extends Node3D
var vid_scene = preload("res://video.tscn")

func _ready() -> void:
	#var viewport = $SubViewport
	var viewport = SubViewport.new()
	
	add_child(viewport)
	var vid_instance = vid_scene.instantiate()
	viewport.add_child(vid_instance)
	var plane  = MeshInstance3D.new()
	
	var vertices = PackedVector3Array()
	
	# maek a collection of vertices that are ok for a plane
	vertices.push_back(Vector3(0,0,0))
	vertices.push_back(Vector3(1,0,0))
	vertices.push_back(Vector3(0,1,0))
	
	vertices.push_back(Vector3(1,0,0))
	vertices.push_back(Vector3(1,1,0))
	vertices.push_back(Vector3(0,1,0))
	var uvs = PackedVector2Array()
	uvs.push_back(Vector2(0,0))
	uvs.push_back(Vector2(1,0))
	uvs.push_back(Vector2(0,1))
	
	uvs.push_back(Vector2(1,0))
	uvs.push_back(Vector2(1,1))
	uvs.push_back(Vector2(0,1))
	# Initialize the ArrayMesh.
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_TEX_UV] = uvs

# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	plane.mesh = arr_mesh
	var vmat = StandardMaterial3D.new()
	vmat.albedo_texture = viewport.get_texture()
	plane.set_surface_override_material(0,vmat)
	#plane.rotate_y(180)
	add_child(plane)
