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

/// 좌표타입 (모든 좌표 속성은 이 좌표타입으로 취급한다.)
typedef NS_ENUM(NSUInteger, KNVCoordType) {
    /// KATEC 좌표계
    KNVCoordTypeKATEC = 1,
    /// WGS84 좌표계
    KNVCoordTypeWGS84 = 2,
};

/// 차종(1~7)
typedef NS_ENUM(NSUInteger, KNVVehicleType) {
    /// 1종(승용차/소형승합차/소형화물화)
    KNVVehicleTypeFirst = 1,
    /// 2종(중형승합차/중형화물차)
    KNVVehicleTypeSecond = 2,
    /// 3종(대형승합차/2축 대형화물차)
    KNVVehicleTypeThird = 3,
    /// 4종(3축 대형화물차)
    KNVVehicleTypeFourth = 4,
    /// 5종(4축이상 특수화물차)
    KNVVehicleTypeFifth = 5,
    /// 6종(경차)
    KNVVehicleTypeSixth = 6,
    /// 이륜차
    KNVVehicleTypeTwoWheel = 7,
};

/// 경로옵션
typedef NS_ENUM(NSUInteger, KNVRpOption) {
    /// 빠른길
    KNVRpOptionFast = 1,
    /// 무료도로
    KNVRpOptionFree = 2,
    /// 최단거리
    KNVRpOptionShortest = 3,
    /// 자동차전용 제외
    KNVRpOptionNoAuto = 4,
    /// 넓은길 우선
    KNVRpOptionWide = 5,
    /// 고속도로 우선
    KNVRpOptionHighway = 6,
    /// 일반도로 우선
    KNVRpOptionNormal = 8,
    /// 추천경로 (기본값)
    KNVRpOptionRecommended = 100,
};

/// 길안내 API의 옵션 설정을 담고 있는 클래스
@interface KNVOptions : NSObject <NSCopying, NSCoding>

/// @abstract 좌표타입
@property (assign, nonatomic) KNVCoordType coordType;

/// @abstract 차종
@property (assign, nonatomic) KNVVehicleType vehicleType;

/// @abstract 경로옵션
@property (assign, nonatomic) KNVRpOption rpOption;

/// @abstract 전체 경로정보 보기 여부
@property (assign, nonatomic) BOOL routeInfo;

/// @abstract 시작위치의 경도 좌표
@property (nullable, copy, nonatomic) NSNumber *startX;

/// @abstract 시작위치의 경도 좌표
@property (nullable, copy, nonatomic) NSNumber *startY;

/// @abstract 시작 앵글 (0~359) 앵글을 설정하지 않을 경우: -1
@property (nullable, copy, nonatomic) NSNumber *startAngle;

/// @abstract 길안내 유저 구분을 위한 USER ID (현재 택시에서 사용)
@property (nullable, copy, nonatomic) NSString *userId;

/// @abstract 길안내 종료(전체 경로보기시 종료) 후 호출 될 URI
@property (nullable, copy, nonatomic) NSString *returnUri;

@end

@interface KNVOptions (Constructor)

+ (nonnull instancetype)options;

@end
