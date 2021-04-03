import React from 'react';
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import Card from 'react-bootstrap/Card';
import Button from 'react-bootstrap/Button';

function Post(){
  return (
      <Container style={{ marginTop: '2em' }}>
        <Card>
          <Card.Header>게시판이름</Card.Header>
          <Card.Body>
            <Card.Title>이번 총회는 온라인입니다</Card.Title>
            <small className="text-muted">작성자: 공희재</small>
            <Card.Text>
              코로나 때문에 이번 총회도 온라인으로 진행될 예정임당~ 신사임당~ 감사함당~
            </Card.Text>
          </Card.Body>
        </Card>
      </Container>
  )
}

export default Post;