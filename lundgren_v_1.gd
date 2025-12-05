extends Node3D

func _ready() -> void:
	var childs = get_children()
	# turn on play for all the animated children
	for child in childs:
		print(child)
		if child.get_child_count() >0:
			childs.append_array(child.get_children())
		if child is AnimatedSprite3D:
			print("yes",child)
			child.play()
