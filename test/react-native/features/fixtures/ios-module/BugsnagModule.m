//
//  BugsnagModule.m
//  reactnative
//
//  Created by Alexander Moinet on 24/06/2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Bugsnag/Bugsnag.h>
#import "BugsnagModule.h"
#import "Scenario.h"

@implementation BugsnagModule

RCT_EXPORT_MODULE(BugsnagTestInterface);

RCT_EXPORT_METHOD(runScenario:(NSString *)scenario completeCallback:(RCTResponseSenderBlock)completeCallback)
{
  Scenario *targetScenario = [Scenario createScenarioNamed:scenario];
  [targetScenario run];
  completeCallback(@[[NSNull null]]);
}

RCT_EXPORT_METHOD(startBugsnag:(NSDictionary *)options readyCallback:(RCTResponseSenderBlock)readyCallback)
{
  BugsnagConfiguration *scenarioConfig = createConfiguration(options);
  [Bugsnag startWithConfiguration:scenarioConfig];
  readyCallback(@[[NSNull null]]);
}

@end

BugsnagConfiguration *createConfiguration(NSDictionary * options) {
  BugsnagConfiguration *config = [[BugsnagConfiguration alloc] initWithApiKey:options[@"apiKey"]];
  NSString *endpoint = options[@"endpoint"];
  BugsnagEndpointConfiguration *endpoints = [[BugsnagEndpointConfiguration alloc] initWithNotify:endpoint sessions:endpoint];
  [config setEndpoints:endpoints];
  return config;
}
