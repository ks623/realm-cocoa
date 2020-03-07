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

#import "RLMObjectId_Private.hpp"

#import "RLMUtil.hpp"

#import <realm/object_id.hpp>

[[clang::objc_runtime_visible]]
@interface RealmSwiftObjectId : RLMObjectId
@end

@implementation RLMObjectId
- (instancetype)init {
    if ((self = [super init])) {
        if (auto cls = [RealmSwiftObjectId class]; cls && cls != self.class) {
            object_setClass(self, cls);
        }
    }
    return self;
}

- (instancetype)initWithString:(NSString *)string error:(NSError **)error {
    if ((self = [self init])) {
        try {
            _value = realm::ObjectId(string.UTF8String);
        }
        catch (std::exception const& e) {
            if (error) {
                *error = RLMMakeError(RLMErrorInvalidInput, e);
            }
            return nil;
        }
    }
    return self;
}

- (instancetype)initWithValue:(realm::ObjectId)value {
    if ((self = [self init])) {
        _value = value;
    }
    return self;
}

+ (instancetype)objectId {
    return [[RLMObjectId alloc] initWithValue:realm::ObjectId::gen()];
}

- (BOOL)isEqual:(id)object {
    if (RLMObjectId *objectId = RLMDynamicCast<RLMObjectId>(object)) {
        return objectId->_value == _value;
    }
    return NO;
}

- (NSUInteger)hash {
    return _value.hash();
}

- (NSString *)description {
    return self.stringValue;
}

- (NSString *)stringValue {
    return @(_value.to_string().c_str());
}
@end
