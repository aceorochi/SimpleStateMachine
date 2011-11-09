//
//  FRRSimpleStateMachine.h
//  DucTape
//
//  Created by Fernando Rodríguez Romero on 10/24/11.
//  Copyright (c) 2011 AGBO Business Architecture, SL. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FRRSimpleStateMachine;

@protocol FRRSimpleStateMachineDelegate
@optional
    -(void) simpleStateMachineWillMoveFromState:(NSString *) oldState 
                                        toState: (NSString *) newState;

    -(void) simpleStateMachineDidMoveFromState:(NSString *) oldState 
                                       toState: (NSString *) newState;

    -(BOOL) simpleStateMachineShouldMoveFromState:(NSString *) oldState 
                                          toState: (NSString *) newState;
@end

@interface FRRSimpleStateMachine : NSObject

@property (copy, nonatomic) NSString *state;
@property (strong, readonly, nonatomic) NSSet *states;
@property (unsafe_unretained) id<FRRSimpleStateMachineDelegate> delegate;

-(id) initWithStates: (NSString *) firstStateName,...;

@end
