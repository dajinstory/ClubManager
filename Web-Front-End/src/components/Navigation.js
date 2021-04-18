import React from 'react';
import logo from '../images/snow_leopard.png';
import profile from '../images/person-circle.svg';
import Button from 'react-bootstrap/Button';
import Navbar from 'react-bootstrap/Navbar';
import Nav from 'react-bootstrap/Nav';
import Form from 'react-bootstrap/Form'
import FormControl from 'react-bootstrap/FormControl'
import Dropdown from 'react-bootstrap/Dropdown'
import { LinkContainer } from 'react-router-bootstrap';

function Navigation() {
  return (
    <Navbar sticky="top" bg="dark" variant="dark">
      <LinkContainer to="/">
        <Navbar.Brand>
          <img src={logo} width="50" className="d-inline-block align-top" alt="logo"/>{` `}
          Club Manager
        </Navbar.Brand>
      </LinkContainer>
      <Form inline>
        <FormControl type="text" placeholder="Search" className="mr-sm-2" />
        <Button variant="outline-success">Search</Button>
      </Form>
      <Nav className="mr-auto"></Nav>
      <Dropdown>
        <Dropdown.Toggle variant="light" id="dropdown-basic">
        <img src={profile} width="25" alt="profile"/>{` `}
        </Dropdown.Toggle>
        <Dropdown.Menu>
          <Dropdown.Item href="#/action-1">Action</Dropdown.Item>
          <Dropdown.Item href="#/action-2">Another action</Dropdown.Item>
          <Dropdown.Item href="#/action-3">Something else</Dropdown.Item>
        </Dropdown.Menu>
      </Dropdown>
      <LinkContainer to="/web/welcome">
        <Button className='m-1' variant="outline-light">Web</Button>
      </LinkContainer>
      <LinkContainer to="/ios">
        <Button className='m-1' variant="outline-light">iOS App</Button>
      </LinkContainer>
    </Navbar>
  );
}

export default Navigation;
