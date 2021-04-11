import React from 'react';
import { LinkContainer } from 'react-router-bootstrap';
import Col from 'react-bootstrap/Col'
import Card from 'react-bootstrap/Card';

function RecentCard({post}){
  // console.log(post);
  return (
    <Col style={{ marginBottom: '1em'}}>
      <LinkContainer to={`/post/${post.id}`} style={{ cursor: 'pointer' }}>
      <Card>
        <Card.Body>
          <Card.Title>{post.title}</Card.Title>
          <Card.Text>
          {post.content}
          </Card.Text>
        </Card.Body>
      </Card>
      </LinkContainer>
    </Col>
  )
}

export default RecentCard;

