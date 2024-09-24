extends Control


@onready var progress_loading = $ProgressBar


func _ready():
	progress_loading.value = 0
	$Loading.start()


func loading_start():
	progress_loading.value += randf_range(0.5, 2.0)

