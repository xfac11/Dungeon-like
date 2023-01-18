extends Node
class_name FiniteStateMachine
export var printNewState:bool = false
var mCurrentState:State
var statesReference = {}
func _ready():
	#Get the children and add it to the dictionary
	#Give the dictionary to the states to be used as references to change state
	var states = get_children()
	for stateRef in states:
		 statesReference[stateRef.get_name()] = stateRef
	for statesRef in states:
		statesRef.stateDictionary = statesReference

func ProcessEvent(event, object, delta):
	var state = mCurrentState.InputUpdate(event, object, delta)
	if state != null:
		mCurrentState.Exit(object)
		mCurrentState = state
		mCurrentState.Enter(object)

func Update(object, delta):
	mCurrentState.Update(object, delta)

func Initiate(startState:State,object):
	mCurrentState = startState
	mCurrentState.Enter(self)
