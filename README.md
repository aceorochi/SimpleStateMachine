# Simple State Machine

A *very* simple state machine implementation in Objective C. States are identified by strings and don't carry
information about what other states can the machine jump to.  This behavior can be added by the machine's
delegate.

##Initialization

The machine is initialized with a list of states (NSStrings):

	-(id) initWithStates: (NSString *) firstStateName,...;

initWithStates: is a variadic method that accepts a list of strings of variable length. The list must end with
nil.

##Properties

- *state* is a read/write property that allows to get and set the current state
- *states* is a _readonly_ property that will return a NSSet with the possible states
- *delegate* points to the State Machine's delegate

##Delegate

The delegate will be notified of state changes and can also prevent a state change. To conform to the protocol,
a class should implement any of the following @ptional methods:

	-(void) simpleStateMachineWillMoveFromState:(NSString *) oldState 
                                        toState: (NSString *) newState;

    -(void) simpleStateMachineDidMoveFromState:(NSString *) oldState 
                                       toState: (NSString *) newState;

    -(BOOL) simpleStateMachineShouldMoveFromState:(NSString *) oldState 
                                          toState: (NSString *) newState;


##Assumptions

This code assumes *ARC*. It also requires my additions to NSObject: _NSObject+FRRObject_.