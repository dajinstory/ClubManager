import React from 'react';
import Image from 'react-bootstrap/Image'
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import Card from 'react-bootstrap/Card'
import { LinkContainer } from 'react-router-bootstrap';
import cat from '../images/cat.jpg';

function Web(){
  return (
    <>
    <Container>
      <h4>내 모임</h4>
      <Row>
        <Col>
          <LinkContainer to='/club'>
            <Image src={cat} className="clubThumbnail" roundedCircle />
          </LinkContainer>
        </Col>
        <Col>
          <LinkContainer to='/club'>
            <Image src={cat} className="clubThumbnail" roundedCircle />
          </LinkContainer>
        </Col>
        <Col>
          <LinkContainer to='/club'>
            <Image src={cat} className="clubThumbnail" roundedCircle />
          </LinkContainer>
        </Col>
        <Col>
          <LinkContainer to='/club'>
            <Image src={cat} className="clubThumbnail" roundedCircle />
          </LinkContainer>
        </Col>
        <Col>
          <LinkContainer to='/club'>
            <Image src={cat} className="clubThumbnail" roundedCircle />
          </LinkContainer>
        </Col>
        <Col>
          <LinkContainer to='/club'>
            <Image src={cat} className="clubThumbnail" roundedCircle />
          </LinkContainer>
        </Col>
      </Row>
    </Container>
    <Container>
      <h4>새 소식</h4>
      <Row>
        <Col>
          <LinkContainer to='/post'>
          <Card>
            <Card.Body>
              <Card.Title>Card Title</Card.Title>
              <Card.Text>
                Some quick example text to build on the card title and make up the bulk of
                the card's content.
              </Card.Text>
            </Card.Body>
          </Card>
          </LinkContainer>
        </Col>
        <Col>
          <LinkContainer to='/post'>
          <Card>
            <Card.Body>
              <Card.Title>Card Title</Card.Title>
              <Card.Text>
                Some quick example text to build on the card title and make up the bulk of
                the card's content.
              </Card.Text>
            </Card.Body>
          </Card>
          </LinkContainer>
        </Col>
      </Row>
      <Row>
        <Col>
          <Card>
            <Card.Body>
              <Card.Title>Card Title</Card.Title>
              <Card.Text>
                Some quick example text to build on the card title and make up the bulk of
                the card's content.
              </Card.Text>
            </Card.Body>
          </Card>
        </Col>
        <Col>
          <Card>
            <Card.Body>
              <Card.Title>Card Title</Card.Title>
              <Card.Text>
                Some quick example text to build on the card title and make up the bulk of
                the card's content.
              </Card.Text>
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </Container>

    </>
  )
}

export default Web;