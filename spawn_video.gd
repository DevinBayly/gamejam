extends Node3D

func _ready() -> void:
	# move the layer 1 video so its left edge sits on the lhs node
	var lhs = $lhs
	var rhs = $rhs
	var ths = $ths
	var vid = $video_layer1
	vid.position = lhs.position
	# calculate the distance to the other side 
	var dist = lhs.position.distance_to(rhs.position)
	print(dist)
	vid.scale = Vector3(dist,dist,dist)
	## so the height or y ends up being 1*scale, when we want it to be rhs->ths dist, so we have to divide by the scale 
	# just to end up with the vert dist matching
	# then we have to do offset z by neg half of that
	# then we need to 
	var vert_dist = rhs.position.distance_to(ths.position)
	print(vert_dist)
	vid.mesh.size.x = 1
	vid.mesh.size.y = vert_dist/dist
	vid.mesh.center_offset = Vector3(.5,0,-vert_dist/(dist*2))
	 
