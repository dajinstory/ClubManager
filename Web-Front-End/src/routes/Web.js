import React from 'react';
import Image from 'react-bootstrap/Image'
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import Card from 'react-bootstrap/Card'
import { LinkContainer } from 'react-router-bootstrap';
import RecentCard from '../components/RecentCard.js';
import cat from '../images/cat.jpg';
import cat2 from '../images/snow_leopard.png';

const posts = [
  {
    id: 1,
    title: "앙!",
    content: "어어아아아앙"
  },
  {
    id: 2,
    title: "애애애오옹!",
    content: "야옹! 야옹! 야옹! 야옹! 야옹! 야옹! 야옹! 야옹! "
  },
  {
    id: 3,
    title: "월워러럴우렁루러!",
    content: "멍! 멍! 멍! 멍! 멍! 멍! 멍! 멍! "
  },
  {
    id: 4,
    title: "앙!4",
    content: "어어아아아앙"
  },
  {
    id: 5,
    title: "5애애애오옹!",
    content: "야옹! 야옹! 야옹! 야옹! 야옹! 야옹! 야옹! 야옹! "
  },
  {
    id: 6,
    title: "6월워러럴우렁루러!",
    content: "멍! 멍! 멍! 멍! 멍! 멍! 멍! 멍! "
  },
];

function Web(){
  return (
    <>
    <Container style={{ marginTop: '2em'}}>
      <h4 style={{ marginBottom: '1em'}}>내 모임</h4>
      {/* {list.map(id => {
        <Col>
          <LinkContainer to={`/club/:${id}`}>
            <Image src={cat} roundedCircle />
          </LinkContainer>
        </Col>
      })
      } */}
      <div class="thumbnail-container">
        <ul class="thumbnail-list">
          <LinkContainer to='/club'>
            <li><span><img class="thumbnail-image" src={cat}/></span>고양이집사</li>
          </LinkContainer>
          <li><span><img class="thumbnail-image" src={cat2}/></span>고양이house사</li>
          <li><span><img class="thumbnail-image" src={cat}/></span>강아지집buy</li>
          <li><span><img class="thumbnail-image" src={cat2}/></span>고슴도치집사</li>
          <li><span><img class="thumbnail-image" src={cat}/></span>어쩌구집사</li>
          <li><span><img class="thumbnail-image" src={cat2}/></span>뱀집사</li>
          <li><span><img class="thumbnail-image" src={cat}/></span>웅앵웅</li>
          <li><span><img class="thumbnail-image" src={cat2}/></span>잉잉</li>
          <li><span><img class="thumbnail-image" src={cat}/></span>앙</li>
        </ul>
      </div>
      {/* <Row className="scroll">
        <Col>
          <LinkContainer to='/club'>
            <Image src={cat} roundedCircle />
          </LinkContainer>
        </Col>
      </Row> */}
    </Container>
    <Container style={{ marginTop: '2em', marginBottom: '2em'}}>
      <h4 style={{ marginBottom: '1em'}}>새 소식</h4>
      <Row xs={1} md={2}>
      {posts.map(post => {
        return (
          <RecentCard
            // id={post.id}
            // title={post.title}
            // content={post.content}
            post={post}
          />
        );
      })}
      </Row>
    </Container>
    </>
  )
}

export default Web;