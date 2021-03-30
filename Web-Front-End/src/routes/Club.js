import React from 'react';
import Container from 'react-bootstrap/Container'
import { Link } from 'react-router-dom';
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import Card from 'react-bootstrap/Card'
import Button from 'react-bootstrap/Button'
import Tabs from 'react-bootstrap/Tabs'
import Tab from 'react-bootstrap/Tab'
import Sonnet from '../components/Sonnet'
import Post from '../routes/Post'
import cat from '../images/cat.jpg';

function Club(){
  return (
    <>
    <Container>
      <Row>
        <Col>
        <Card style={{ width: '16rem' }}>
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
              <Link to='/post' style={{ textDecoration: 'none', color: 'inherit' }}>
                <Post />
              </Link>
            </Tab>
            <Tab eventKey="schedule" title="Schedule">
              <Sonnet />
            </Tab>
            <Tab eventKey="reserve" title="Reserve">
              <Sonnet />
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