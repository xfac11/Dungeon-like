extends Node
class_name FiniteStateMachine
var current_state:State
var states_reference = {}
func _ready():
	#Get the children and add it to the dictionary
	#Give the dictionary to the states to be used as references to change state
	var states = get_children()
	for stateRef in states:
		 states_reference[stateRef.get_name()] = stateRef
	for statesRef in states:
		statesRef.stateDictionary = states_reference

func process_event(event, object, delta):
	var state = current_state._inputUpdate(event, object, delta)
	if state != null:
		current_state._exit(object)
		current_state = state
		current_state._enter(object)

func update(object, delta):
	current_state._update(object, delta)

func initiate(start_state:State, _object):
	current_state = start_state
	current_state._enter(self)
