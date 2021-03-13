import React from 'react';
import { HashRouter, Route } from 'react-router-dom';
import Navigation from './components/Navigation';
import Home from './routes/Home';
import Web from './routes/Web';
import Club from './routes/Club';
import Post from './routes/Post';

function App() {
  return (
    <HashRouter>
      <Navigation />
      <Route path="/" exact={true} component={Home}/>
      <Route path="/web" component={Web}/>
      <Route path="/club" component={Club}/>
      <Route path="/post" component={Post}/>
    </HashRouter>
  );
}

export default App;
