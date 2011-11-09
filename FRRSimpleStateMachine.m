//
//  FRRSimpleStateMachine.m
//  DucTape
//
//  Created by Fernando Rodríguez Romero on 10/24/11.
//  Copyright (c) 2011 AGBO Business Architecture, SL. All rights reserved.
//

#import "FRRSimpleStateMachine.h"
#import "NSObject+FRRObject.h"

@interface FRRSimpleStateMachine()
    
    @property (strong) NSMutableSet *_states;
    @property (strong) NSString *_currentState;
    -(BOOL) canMoveFromState: (NSString *) oldState toState: (NSString *) newState;
     
@end

@implementation FRRSimpleStateMachine

#pragma mark - Properties
@synthesize state, states, delegate, _states, _currentState;

-(NSString *) state{
    return self._currentState;
}

-(NSSet *) states{
    return [self._states copy];
}

-(void) setState:(NSString *)newState{
   
    if ([self._states member:newState] && ![newState isEqualToString:self._currentState]) {
        
        if ([self canMoveFromState:self._currentState toState:newState]) {
            
            [(NSObject*)self.delegate performBlock:^{
                [self.delegate simpleStateMachineWillMoveFromState:self._currentState toState:newState];
            } ifRespondsTo:@selector(simpleStateMachineWillMoveFromState:toState:)];
            
            NSString *oldState = self._currentState;
            self._currentState = newState;
            
            [(NSObject *)self.delegate performBlock:^{
                [self.delegate simpleStateMachineDidMoveFromState:oldState toState:newState];
            } ifRespondsTo:@selector(simpleStateMachineDidMoveFromState:toState:)]; 
            
        }
    }
}

#pragma mark - initialization
-(id) init{
    return [self initWithStates:nil];
}

-(id) initWithStates: (NSString *) firstStateName,...{
    
    
    if (self = [super init]) {
        va_list rawStates;
        va_start(rawStates, firstStateName);
        NSString *currentStateName = nil;
        self._states = [[NSMutableSet alloc] init];
        
        for (currentStateName = firstStateName; currentStateName; currentStateName = va_arg(rawStates, NSString*)) {
            [self._states addObject:currentStateName];
        }
        va_end(rawStates);
    }
        
    return self;
    
}

#pragma mark - Utility methods
-(BOOL) canMoveFromState: (NSString *) oldState 
                 toState: (NSString *) newState{
    BOOL goAhead = NO;
    if ([(NSObject*)self.delegate respondsToSelector:@selector(simpleStateMachineShouldMoveFromState:toState:)]) {
        goAhead = [self.delegate simpleStateMachineShouldMoveFromState:self._currentState toState:newState];
    }else{
        goAhead = YES;
    }
    return goAhead;
}


@end
