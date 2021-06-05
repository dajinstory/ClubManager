import React, { Component } from 'react';
import axios from 'axios';
import { LinkContainer } from 'react-router-bootstrap';
import JAVASCRIPT_KEY from '../.kakao_login_key.js';
// 참고한 링크: [[Front end] SNS 로그인 연동(네이버, 카카오) with React](https://reference-m1.tistory.com/368)
// 카카오로그인 api 문서는 javascript 문서를 참고한다
// 나중에 참고해야 할 링크: [React Router로 사용자 인증하기 (로그인/로그아웃)](https://www.daleseo.com/react-router-authentication/)
// 또 참고한 링크: https://velog.io/@sayi/React-%EC%B9%B4%EC%B9%B4%EC%98%A4-%EB%A1%9C%EA%B7%B8%EC%9D%B8%EB%A1%9C%EA%B7%B8%EC%9D%B8-%EC%82%AC%EC%9A%A9%EC%9E%90-%EC%A0%95%EB%B3%B4-%EC%88%98%EC%A7%91
class Profile extends Component {
  constructor(props) {
    super(props);
    this.state = {
      is_user_logged_in: false,
      user_email: 'empty',
      user_nickname: 'empty',
    };
  }
  createUser = (email, nickname) => {
    // axios.post('http://3.36.64.38:47000/user',
    // {
    //   "name" : nickname,
    //   "email" : email,
    //   "clubs" : ""
    // });
  }
  getUser = async () => {
    // const users = await axios.get('http://3.36.64.38:47000/user')
    const users = [
      {
        id : 120,
        name : "조소정",
        auth : 3,
        email: 'heejaykong@naver.com',
      },
    ]

    let isNewMember = false;
    users.map(user => {
      if (user.email === this.state.user_email) {
        console.log('보아하니 우리 디비에도 있군요')
        isNewMember = true
      }
    })
    if (isNewMember) {
      this.createUser(this.state.user_email, this.state.user_nickname);
    }
  }
  componentDidMount(){

    const kakaoScript = document.createElement('script');
    kakaoScript.src='https://developers.kakao.com/sdk/js/kakao.js';
    document.head.appendChild(kakaoScript);

    kakaoScript.onload = () => {
      window.Kakao.init(JAVASCRIPT_KEY);
      // console.log(window.Kakao.isInitialized());

      // test를 위해 처음엔 무조건 로그아웃
      if (window.Kakao.Auth.getAccessToken()) {
        window.Kakao.API.request({
          url: '/v1/user/unlink',
          success: (res) => {
            console.log(res)
            
            this.setState({
              ...this.state,
              is_user_logged_in: false
            })

            localStorage.removeItem('kakao_9aafa9f8986748aa3a7c4a065fecafda');
          },
          fail: (error) => {
            console.log(error) },
          }
        )
        window.Kakao.Auth.setAccessToken(undefined)
      }

      // 로그인
      window.Kakao.Auth.createLoginButton({
        container: "#kakao-login-btn",
        success: (auth) => {
          console.log("카카오 로그인 완료", auth);
          window.Kakao.API.request({
            url:'/v2/user/me',
            data: {
              property_keys: ["kakao_account.email","kakao_account.profile.nickname", "kakao_account.profile.profile_image_url"]
            },
            success: (res) => {
              console.log('카카오 사용자 정보', res);
              console.log('email:', res.kakao_account.email);

              this.setState({
                ...this.state,
                is_user_logged_in: true,
                user_email: res.kakao_account.email,
                user_nickname: res.kakao_account.profile.nickname,
              })
              
            this.getUser()
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
      <dd>{this.state.is_user_logged_in? this.state.user_email : 'not yet'}</dd>
      <dt>Name</dt>
      <dd>{this.state.is_user_logged_in? this.state.user_nickname: 'not yet'}</dd>
      </>
    );
  }
}

export default Profile;
