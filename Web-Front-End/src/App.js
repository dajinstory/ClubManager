import React from 'react';
import { HashRouter, Route } from 'react-router-dom';
import Navigation from './components/Navigation';
import Home from './routes/Home';
import Web from './routes/Web';
import Club from './routes/Club';
import Post from './routes/Post';
import Reserve from './routes/Reserve';
import Footer from './components/Footer';
// dummy data
import clubs from './dummy-data/clubs.js';

const posts = [].concat(...clubs.map(club=>club.posts));
// console.log(posts);

function App() {
  return (
    <HashRouter>
      <Navigation />
      <Route path="/" exact={true} component={Home}/>
      <Route path="/web" component={Web}/>
      {/* <Route path="/club" component={Club}/> */}
      <Route path="/club/:id" render={ ({match}) => {
        return <Club club={ clubs.find(c => c.id === parseInt(match.params.id)) } />
      }}/>
      
      {/* <Route path="/post" component={Post}/> */}
      <Route path={"/post/:id"} render={ ({match}) => {
        return <Post post={ posts.find(p => p.id === parseInt(match.params.id)) } />
      }} />
      <Route path="/reserve" component={Reserve}/>
      <Footer />
    </HashRouter>
  );
}

export default App;
