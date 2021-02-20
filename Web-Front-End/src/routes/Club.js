import React from 'react';
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import Card from 'react-bootstrap/Card'
import Button from 'react-bootstrap/Button'
import Tabs from 'react-bootstrap/Tabs'
import Tab from 'react-bootstrap/Tab'
import Sonnet from '../components/Sonnet'
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
          <Tabs defaultActiveKey="profile" id="uncontrolled-tab-example">
            <Tab eventKey="all" title="All">
              <Sonnet />
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