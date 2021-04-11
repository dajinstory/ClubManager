/*
 * Copyright 2016 Kakao Corp.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <Foundation/Foundation.h>

@class KNVLocation;
@class KNVOptions;

NS_ASSUME_NONNULL_BEGIN

/// 카카오내비 API 호출을 위한 파라미터 정보 클래스
@interface KNVParams : NSObject <NSCoding>

/// @abstract 목적지 기본 정보 (required)
@property (readonly) KNVLocation *destination;

/// @abstract 옵션 정보
@property (nullable, copy, nonatomic) KNVOptions *options;

/// @abstract 경유지 정보 (최대 3개)
@property (nullable, copy, nonatomic) NSArray<KNVLocation *> *viaList;

@end

@interface KNVParams (Constructor)

+ (instancetype)paramWithDestination:(KNVLocation *)destination;
+ (instancetype)paramWithDestination:(KNVLocation *)destination options:(nullable KNVOptions *)options;
+ (instancetype)paramWithDestination:(KNVLocation *)destination viaList:(nullable NSArray<KNVLocation *> *)viaList;
+ (instancetype)paramWithDestination:(KNVLocation *)destination options:(nullable KNVOptions *)options viaList:(nullable NSArray<KNVLocation *> *)viaList;
- (instancetype)initWithDestination:(KNVLocation *)destination;
- (instancetype)initWithDestination:(KNVLocation *)destination options:(nullable KNVOptions *)options;
- (instancetype)initWithDestination:(KNVLocation *)destination viaList:(nullable NSArray<KNVLocation *> *)viaList;
- (instancetype)initWithDestination:(KNVLocation *)destination options:(nullable KNVOptions *)options viaList:(nullable NSArray<KNVLocation *> *)viaList;

@end

NS_ASSUME_NONNULL_END
