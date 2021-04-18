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
// dummy data
import posts from '../dummy-data/posts.js';
import clubs from '../dummy-data/clubs.js';

function Web(){
  return (
    <>
    <Container style={{ marginTop: '2em'}}>
      <h4 style={{ marginBottom: '1em'}}>내 모임</h4>
      <div className="thumbnail-container">
        <ul className="thumbnail-list">
          {clubs.map((club, index) => {
            return (
              <LinkContainer to={`/${club.name}`} key={index}>
                <li><span><img className="thumbnail-image" src={cat}/></span>{club.name}</li>
              </LinkContainer>
            )
          })}
        </ul>
      </div>
    </Container>
    <Container style={{ marginTop: '2em', marginBottom: '2em'}}>
      <h4 style={{ marginBottom: '1em'}}>새 소식</h4>
      <Row xs={1} md={2}>
      {posts.map((post,index) => {
        return (
          <RecentCard
            key={index}
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