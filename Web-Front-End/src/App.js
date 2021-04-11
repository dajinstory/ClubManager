import React from 'react';
import { HashRouter, Route } from 'react-router-dom';
import Navigation from './components/Navigation';
import Home from './routes/Home';
import Web from './routes/Web';
import Club from './routes/Club';
import Post from './routes/Post';
import Reserve from './routes/Reserve';
import Footer from './components/Footer';

const posts = [
  {
    id: 1,
    title: "앙!",
    content: "어어아아아앙"
  },
  {
    id: 2,
    title: "애애애오옹!",
    content: "야옹! 야옹! 야옹! 야옹! 야옹! 야옹! 야옹! 야옹! "
  },
  {
    id: 3,
    title: "월워러럴우렁루러!",
    content: "멍! 멍! 멍! 멍! 멍! 멍! 멍! 멍! "
  },
  {
    id: 4,
    title: "앙!4",
    content: "어어아아아앙"
  },
  {
    id: 5,
    title: "5애애애오옹!",
    content: "야옹! 야옹! 야옹! 야옹! 야옹! 야옹! 야옹! 야옹! "
  },
  {
    id: 6,
    title: "6월워러럴우렁루러!",
    content: "멍! 멍! 멍! 멍! 멍! 멍! 멍! 멍! "
  },
];

function App() {
  return (
    <HashRouter>
      <Navigation />
      <Route path="/" exact={true} component={Home}/>
      <Route path="/web" component={Web}/>
      <Route path="/club" component={Club}/>
      {/* <Route path="/post" component={Post}/> */}
      <Route path={"/post/:id"} render={ ({match}) => {
        console.log(match);
        return <Post post={ posts.find(p => p.id === parseInt(match.params.id)) } />
      }} />
      <Route path="/reserve" component={Reserve}/>
      <Footer />
    </HashRouter>
  );
}

export default App;
