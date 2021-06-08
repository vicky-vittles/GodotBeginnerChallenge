extends Node
class_name GameQuitter

func quit():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
