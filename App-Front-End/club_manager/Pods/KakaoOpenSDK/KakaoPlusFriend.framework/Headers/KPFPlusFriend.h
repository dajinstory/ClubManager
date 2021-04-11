/*
 * Copyright 2018 Kakao Corp.
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

NS_ASSUME_NONNULL_BEGIN

/// 카카오톡 채널 연동 기능을 제공하는 클래스입니다.
@interface KPFPlusFriend : NSObject

/// @abstract 카카오톡 채널 ID
@property (readonly) NSString *Id;

@end

@interface KPFPlusFriend (Initializer)

/// @abstract 채널 연동을 위해 인스턴스를 생성합니다.
/// @param Id **카카오톡 채널 ID**
/// <br>카카오톡 채널 홈 URL에 들어간 {_영문}으로 구성된 고유 ID를 입력해주세요. 홈 URL은 카카오톡 채널 관리자센터 > 관리 > 상세설정 페이지에서 확인할 수 있습니다.
- (instancetype)initWithId:(NSString *)Id;

@end

@interface KPFPlusFriend (API)

/// @abstract 채널 추가 기능을 실행합니다.
/// @discussion addFriendURL을 이용하여 사파리 뷰컨트롤러에 브릿지 페이지를 로딩합니다. 페이지 로딩이 완료되면 해당 채널을 추가할 수 있는 카카오톡 커스텀 스킴을 실행합니다.
- (BOOL)addFriend;

/// @abstract 1:1 채팅 기능을 실행합니다.
/// @discussion chatURL을 이용하여 사파리 뷰컨트롤러에 브릿지 페이지를 로딩합니다. 페이지 로딩이 완료되면 해당 채널 1:1 채팅 기능이 있는 카카오톡 커스텀 스킴을 실행합니다.
- (BOOL)chat;

/// @abstract 채널 추가 기능을 위한 브릿지 페이지 URL을 반환합니다.
- (NSURL *)addFriendURL;

/// @abstract 1:1 채팅 기능을 위한 브릿지 페이지 URL을 반환합니다.
- (NSURL *)chatURL;

@end

NS_ASSUME_NONNULL_END
