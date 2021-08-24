extends MultiMeshInstance

func _ready():
	for i in multimesh.visible_instance_count:
		multimesh.set_instance_transform(i, Transform(Basis(), Vector3(i * 20, 0, 0)))
