class_name FadeEffect extends Effect

func apply_tween(tween: Tween):
	interpolate_all(tween, "modulate", Color.transparent)
