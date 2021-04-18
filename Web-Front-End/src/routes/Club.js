import React from 'react';
import Container from 'react-bootstrap/Container'
import { Link } from 'react-router-dom';
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import Card from 'react-bootstrap/Card'
import Button from 'react-bootstrap/Button'
import Tabs from 'react-bootstrap/Tabs'
import Tab from 'react-bootstrap/Tab'
import Badge from 'react-bootstrap/Badge'
import Sonnet from '../components/Sonnet'
import Post from '../routes/Post'
import cat from '../images/cat.jpg';
// dummy data
// import posts from '../dummy-data/posts.js';
import schedules from '../dummy-data/schedules.js';

function Club({club}){
  const posts = club.posts;
  return (
    <>
    <Container style={{ marginTop: '2em'}}>
      <Row>
        <Col>
        <Card style={{ width: '16rem'}}>
          <Card.Img variant="top" src={cat} />
          <Card.Body>
            <Card.Title>{club.name}</Card.Title>
            <Card.Text>
              Some quick example text to build on the card title and make up the bulk of
              the card's content.
            </Card.Text>
            <Button variant="primary">Go somewhere</Button>
          </Card.Body>
        </Card>
        </Col>
        <Col>
          <Tabs defaultActiveKey="all" id="uncontrolled-tab-example">
            <Tab eventKey="all" title="All">
              {/* <Link to={`/${club.name}/posts`} style={{ color: 'inherit', fontSize:'1rem'}}> */}
                <span>전체 보기</span>
              {/* </Link> */}
              {posts.map((post,index) => {
                return(
                  <Link key={index} to={`/post/${post.id}`} style={{ textDecoration: 'none', color: 'inherit' }}>
                    <Post post={post} />
                  </Link>
                )
              })}
            
            </Tab>
            <Tab eventKey="schedule" title="Schedule">
              {
              schedules.map((item,index) => {
                return (
                  <div key={index}>
                    <Badge pill variant="primary">
                      {item.date}
                    </Badge>
                    <span>{item.title}</span>
                  </div>
                )
              })
              }
            </Tab>
            <Tab eventKey="reserve" title="Reserve">
              <Link to='/reserve' style={{ color: 'inherit' }}>예약하러 가자</Link>
            </Tab>
          </Tabs>
        </Col>
        <Col>
        </Col>
      </Row>
    </Container>
    </>
  )
}

export default Club;