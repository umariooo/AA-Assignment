extends Node

enum Status { SUCCESS, FAILURE, RUNNING }

var nyra: MeshInstance3D
var emotion_node

func _ready() -> void:
	nyra = get_parent()
	emotion_node = nyra.get_node("Emotion")

func tick() -> Status:
	# Selector - tries each child until one succeeds
	if check_threatened():
		return Status.SUCCESS
	if check_sleeping():
		return Status.SUCCESS
	if check_lonely():
		return Status.SUCCESS
	if check_curious():
		return Status.SUCCESS
	return run_content()

func check_threatened() -> bool:
	return emotion_node.current == emotion_node.State.THREATENED

func check_sleeping() -> bool:
	return emotion_node.current == emotion_node.State.SLEEPING

func check_lonely() -> bool:
	return emotion_node.current == emotion_node.State.LONELY

func check_curious() -> bool:
	return emotion_node.current == emotion_node.State.CURIOUS

func run_content() -> Status:
	return Status.RUNNING
