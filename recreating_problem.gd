extends Node3D
var vid_scene = preload("res://video.tscn")

func _ready() -> void:
	#var viewport = $SubViewport
	var viewport = SubViewport.new()
	
	add_child(viewport)
	var vid_instance = vid_scene.instantiate()
	viewport.add_child(vid_instance)
	var plane  = MeshInstance3D.new()
	plane.mesh = QuadMesh.new()
	
	var vmat = StandardMaterial3D.new()
	vmat.albedo_texture = viewport.get_texture()
	plane.set_surface_override_material(0,vmat)
	plane.rotate_y(180)
	add_child(plane)
func _old() -> void:
	var vmat = StandardMaterial3D.new()
	var custom_plane = MeshInstance3D.new()
	var vertices = PackedVector3Array()
	
	# maek a collection of vertices that are ok for a plane
	vertices.push_back(Vector3(0,0,0))
	vertices.push_back(Vector3(1,0,0))
	vertices.push_back(Vector3(0,1,0))
	
	vertices.push_back(Vector3(1,0,0))
	vertices.push_back(Vector3(1,1,0))
	vertices.push_back(Vector3(0,1,0))

	# Initialize the ArrayMesh.
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices

# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	arr_mesh.resource_local_to_scene=true
	custom_plane.mesh = arr_mesh
	add_child(custom_plane)
	
	vmat.resource_local_to_scene = true
	
	var viewport = SubViewport.new()
	
	add_child(viewport)
	var vid_instance = vid_scene.instantiate()
	viewport.add_child(vid_instance)
	# now we have to add things to the vmat
	vmat.albedo_texture = viewport.get_texture()
	custom_plane.set_surface_override_material(0,vmat)
	
	
	
