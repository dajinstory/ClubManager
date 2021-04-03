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

const schedules = [
  {
    title: "합주",
    date: "2020-01-01"
  },
  {
    title: "스터디",
    date: "2020-03-01"
  },
  {
    title: "연습",
    date: "2020-03-12"
  },
]
function Club(){
  return (
    <>
    <Container style={{ marginTop: '2em'}}>
      <Row>
        <Col>
        <Card style={{ width: '16rem'}}>
          <Card.Img variant="top" src={cat} />
          <Card.Body>
            <Card.Title>Card Title</Card.Title>
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
              <Link to='/post' style={{ color: 'inherit', fontSize:'1rem'}}>
                <span>전체 보기> </span>
              </Link>
              <Link to='/post' style={{ textDecoration: 'none', color: 'inherit' }}>
                <Post />
              </Link>
            </Tab>
            <Tab eventKey="schedule" title="Schedule">
              {
              schedules.map(item => {
                return (
                  <div>
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
              <Link to='/reserve' style={{ color: 'inherit' }}>예약하러 가자 >></Link>
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