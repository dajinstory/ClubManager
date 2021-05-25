import React, { Component } from 'react';
import { LinkContainer } from 'react-router-bootstrap';
import JAVASCRIPT_KEY from '../.kakao_login_key.js';
// 참고한 링크: [[Front end] SNS 로그인 연동(네이버, 카카오) with React](https://reference-m1.tistory.com/368)
// 나중에 참고해야 할 링크: [React Router로 사용자 인증하기 (로그인/로그아웃)](https://www.daleseo.com/react-router-authentication/)
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
