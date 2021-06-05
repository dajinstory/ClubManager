import React, { Component } from 'react';
import { LinkContainer } from 'react-router-bootstrap';
import JAVASCRIPT_KEY from '../.kakao_login_key.js';
// 참고한 링크 https://reference-m1.tistory.com/368
class Profile extends Component {
  componentDidMount(){
    const kakaoScript = document.createElement('script');
    kakaoScript.src='https://developers.kakao.com/sdk/js/kakao.js';
    document.head.appendChild(kakaoScript);

    kakaoScript.onload = () => {
      window.Kakao.init(JAVASCRIPT_KEY);
      // console.log(window.Kakao.isInitialized());
      window.Kakao.Auth.createLoginButton({
        container: "#kakao-login-btn",
        success: (auth) => {
          console.log("카카오 로그인 완료", auth);
          window.Kakao.API.request({
            url:'/v2/user/me',
            success: (res) => {
              console.log('카카오 사용자 정보', res);
            },
            fail: (err)=>{
              console.log(err);
            },
          });
        },
        fail: (err) => {
          console.log(err);
        }
      });
    }
  }
  
  render(){
    return (
      <>
      <button id='kakao-login-btn'></button>
      <h1>Profile</h1>
      <dt>Email</dt>
      {/* <dd>{email}</dd> */}
      <dt>Password</dt>
      {/* <dd>{password}</dd> */}
      <dt>Name</dt>
      {/* <dd>{name}</dd> */}
      </>
    );
  }
}

export default Profile;
