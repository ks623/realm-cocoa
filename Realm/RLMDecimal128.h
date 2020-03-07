////////////////////////////////////////////////////////////////////////////
//
// Copyright 2020 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RLMDecimal128 : NSObject
- (instancetype)init;
- (instancetype)initWithNumber:(NSNumber *)number;
- (instancetype)initWithNSDecimal:(NSDecimalNumber *)number;
- (nullable instancetype)initWithString:(NSString *)string error:(NSError *_Nullable*)error;

+ (instancetype)decimalWithNumber:(NSNumber *)number;
+ (instancetype)decimalWithNSDecimal:(NSDecimalNumber *)number;
+ (instancetype)decimalWithString:(NSString *)string error:(NSError **)error;

@property (nonatomic, readonly) double doubleValue;
@property (nonatomic, readonly) NSDecimal decimalValue;
@property (nonatomic, readonly) NSString *stringValue;
@end

NS_ASSUME_NONNULL_END
