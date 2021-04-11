import React from 'react';
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import Card from 'react-bootstrap/Card';
import Button from 'react-bootstrap/Button';

function Post({post}){
  return (
    <>
      <Container style={{ marginTop: '2em' }}>
        <Card>
          <Card.Header>게시판이름</Card.Header>
          <Card.Body>
            <Card.Title>{post.title}</Card.Title>
            <small className="text-muted">작성자: 공희재</small>
            <Card.Text>
              {post.content}
            </Card.Text>
          </Card.Body>
        </Card>
      </Container>
    </>
  )
}

export default Post;