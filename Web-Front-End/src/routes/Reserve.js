import React from 'react';
import FullCalendar from '@fullcalendar/react';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from "@fullcalendar/interaction"; // needed for dayClick
import Container from 'react-bootstrap/Container'

function Reserve(){
  const setState = (newState) => {
    console.log('ㄱㄹㅎㄷ');
  }
  const handleDateClick = (arg) => {
    console.log(arg)
    const event = prompt(`${arg.dateStr} enter your event`);
    alert(event);
  }
  return (
    <Container style={{ marginTop: '2em', marginBottom: '2em'}}>
      <FullCalendar
        plugins={[ dayGridPlugin, interactionPlugin ]}
        initialView='dayGridMonth'
        events={[
          { title: 'event 1', date: '2021-04-01' },
          { title: 'event 2', date: '2021-04-02' }
        ]}
        dateClick={handleDateClick}
      />
    </Container>
  )
}

export default Reserve;