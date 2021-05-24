import React from 'react';
import { HashRouter, Switch, Route } from 'react-router-dom';
import Navigation from './components/Navigation';
import Home from './routes/Home';
import Profile from './routes/Profile';
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
      <Switch>
        <Route path="/" exact={true} component={Home}/>
        <Route path="/profile" exact={true} component={Profile}/>
        <Route path="/web" exact={true} component={Web}/>
        <Route path="/post/:id" render={ ({match}) => {
          return <Post post={ posts.find(p => p.id === parseInt(match.params.id)) } />
        }}
        />
        <Route path="/reserve" component={Reserve}/>
        <Route path="/:clubName" exact={true} render={ ({match}) => {
          return <Club club={ clubs.find(c => c.name === match.params.clubName) } />
        }}
        />
        <Route path="/:clubName/posts" render={({match}) => {
          const allPosts = (clubs.find(c=>c.name===match.params.clubName)).posts;
          return allPosts.map((post, index) => <Post key={index} post={post} />)
        }}
        />
      </Switch>
      <Footer />
    </HashRouter>
  );
}

export default App;
