import React from 'react';
import Image from 'react-bootstrap/Image'
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import Card from 'react-bootstrap/Card'
import { LinkContainer } from 'react-router-bootstrap';
import cat from '../images/cat.jpg';
import cat2 from '../images/snow_leopard.png';


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
      {/* {foodILike.map(dish => (
        <Food key={dish.id} name={dish.name} picture={dish.image} />
      ))} */}
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
      <Row>
        <Col style={{ marginBottom: '1em'}}>
          <LinkContainer to='/post' style={{ cursor: 'pointer' }}>
          <Card>
            <Card.Body>
              <Card.Title>이번 총회는 온라인입니다</Card.Title>
              <Card.Text>
              코로나 때문에 이번 총회도 온라인으로 진행될 예정임당~ 신사임당~ 감사함당~
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