class_name HoneyMethod
extends HoneyAnimation


var _method : FuncRef = null setget _set_method,_get_method
var _from setget _set_from,_get_from
var _to setget _set_to,_get_to
var _is_from := true setget _set_is_from,_get_is_from
var _as_relative := false setget _set_to,_get_to


func _init(from) -> void:
	_set_from(from)


func anima_method(method: FuncRef,from,to_value,duration: float) -> HoneyMethod:
	_set_method(method)
	_set_from(from)
	_set_to(to_value)
	_set_duration(duration)
	return self


func _animation_step() -> void:
	var time_normalized := _check_ease(_get_time_normalized()) as float
	var animation_value = _get_from() + (_get_to() - _get_from()) * time_normalized * _get_time_direction()
	if _get_on_step() != null:
		_get_on_step().call_funcv([animation_value])
	if _get_method().is_valid() == true:
		_get_method().call_func(animation_value)
	else:
		_get_target().call(_get_method().function, animation_value)
	emit_signal("animation_step", animation_value)


func _check_loop_type() -> void:
	if _get_loop_type() == LoopType.Restart:
		_get_method().call_func(_get_from())
	elif _get_loop_type() == LoopType.Yoyo:
		var old_from = _get_from()
		var old_to = _get_to()
		_set_to(old_from)
		_set_from(old_to)
		_get_method().call_func(_get_from())


func on_started(func_ref: FuncRef) -> HoneyMethod:
	_set_on_started(func_ref)
	return self


func on_step(func_ref: FuncRef) -> HoneyMethod:
	_set_on_step(func_ref)
	return self


func on_running(func_ref: FuncRef) -> HoneyMethod:
	_set_on_running(func_ref)
	return self


func on_finished(func_ref: FuncRef) -> HoneyMethod:
	_set_on_finished(func_ref)
	return self


func on_loop_finished(func_ref: FuncRef) -> HoneyMethod:
	_set_on_loop_finished(func_ref)
	return self


func on_infinity_loop_finished(func_ref: FuncRef) -> HoneyMethod:
	_set_on_infinity_loop_finished(func_ref)
	return self


func on_delay_finished(func_ref: FuncRef) -> HoneyMethod:
	_set_on_delay_finished(func_ref)
	return self


func on_rewind(func_ref: FuncRef) -> HoneyMethod:
	_set_on_rewind(func_ref)
	return self


func on_paused(func_ref: FuncRef) -> HoneyMethod:
	_set_on_paused(func_ref)
	return self


func on_flip(func_ref: FuncRef) -> HoneyMethod:
	_set_on_flip(func_ref)
	return self


func update_from() -> HoneyMethod:
	return self


func play() -> HoneyMethod:
	_handle_started()
	return self


func set_speed_scale(value: float) -> HoneyMethod:
	_set_speed_scale(value)
	return self


func set_delay(value: float) -> HoneyMethod:
	_set_delay(value)
	_set_initial_delay(value)
	return self


func set_loops(value: int,loop_type: String = LoopType.Restart) -> HoneyMethod:
	_set_loop_count(value)
	_set_loop_type(loop_type)
	return self
	
	
func paused() -> HoneyMethod:
	_set_paused(true)
	emit_signal("animation_paused")
	return self


func resume() -> HoneyMethod:
	_set_paused(false)
	return self


func reset() -> HoneyMethod:
	_set_started(false)
	_set_playing(false)
	_set_finished(false)
	_set_paused(false)
	_set_elapsed_time(EmptyTime)
	_handle_loop_type()
	_set_delay(_get_initial_delay())
	return self


func set_ease(value) -> HoneyMethod:
	_set_ease(value)
	return self


func _set_target(value: Object) -> HoneyMethod:
	_target = value
	return self
	

func _set_method(value: FuncRef) -> void:
	_method = value


func _get_method() -> FuncRef:
	return _method


func _set_from(value) -> void:
	_from = value


func _get_from():
	return _from


func _set_to(value) -> void:
	_to = value


func _get_to():
	return _to


func _set_is_from(value: bool) -> void:
	_is_from = value


func _get_is_from() -> bool:
	return _is_from


func _set_as_relative(value: bool) -> void:
	_as_relative = value


func _get_as_relative() -> bool:
	return _as_relative
