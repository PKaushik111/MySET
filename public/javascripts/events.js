// events.js
function retrieveAllEvents() {
    let req = new XMLHttpRequest();

    req.onreadystatechange = function () {
        if (req.readyState == 4 && req.status == 200) {
            var response = JSON.parse(this.responseText);
            // Perform any necessary actions with the response data
            console.log(response);
            displayEvents(response);
        }
    };

    req.open('GET', '/events');
    req.send();
}

function displayEvents(events) {
    const eventsContainer = document.getElementById('events-container');
    let urlParams = new URLSearchParams(window.location.search);
    let loggedIn = urlParams.get('loggedIn');

    // Clear previous events
    eventsContainer.innerHTML = '';

    // Iterate over the events and create HTML elements to display them
    events.forEach(function (event) {
        const eventDiv = document.createElement('div');
        eventDiv.classList.add('event-widget');

        const dateWidget = document.createElement('div');
        dateWidget.classList.add('date-widget');

        // Convert the event date string to a Date object
        const eventDate = new Date(event.event_datetime);

        // Get the individual date components
        const day = String(eventDate.getDate()).padStart(2, '0');
        const month = String(eventDate.getMonth() + 1).padStart(2, '0');
        const year = eventDate.getFullYear();

        // Format the date as DD-MM-YYYY
        const formattedDate = `${day}/${month}/${year}`;

        dateWidget.textContent = formattedDate;
        eventDiv.appendChild(dateWidget);

        const titleWidget = document.createElement('p');
        titleWidget.classList.add('title-widget');
        titleWidget.textContent = event.event_name;
        eventDiv.appendChild(titleWidget);

        // alert(event.title);

        const description = document.createElement('p');
        description.textContent = event.event_description;
        eventDiv.appendChild(description);

        // const rsvpButton = document.createElement('button');
        // rsvpButton.textContent = 'RSVP';
        // rsvpButton.classList.add('RSVP-BUTTON');
        // rsvpButton.addEventListener('click', function () {
        //     // Perform RSVP action
        //     alert('RSVP clicked for event: ' + event.event_name);
        // });
        // eventDiv.appendChild(rsvpButton);

        if (loggedIn) {
            let loginBtn = document.getElementById('login-btn');
            if (loginBtn) {
                const rsvpButton = document.createElement('button');
                rsvpButton.textContent = 'RSVP';
                rsvpButton.classList.add('RSVP-BUTTON');
                rsvpButton.addEventListener('click', function () {
                    // Perform RSVP action
                    alert('RSVP clicked for event: ' + event.event_name);
                })
                eventDiv.appendChild(rsvpButton);
            }
        }

        eventsContainer.appendChild(eventDiv);
    });
}

function rsvp(){

    let req = new XMLHttpRequest();

    req.onreadystatechange = function () {
        if (req.readyState == 4 && req.status == 200) {
            alert("You have registered for the event.")
        }
    };

    req.open('POST', '/rsvp');
    req.setRequestHeader('Content-Type', 'application/json');
    req.send();

}


// new Vue({
//     el: '#app',
//     data: {
//         events: []
//     },
//     mounted() {
//         this.fetchEvents();
//     },
//     methods: {
//         fetchEvents() {
//             fetch('/events')
//                 .then(response => response.json())
//                 .then(data => {
//                     this.events = data;
//                 })
//                 .catch(error => {
//                     console.error('Error fetching events:', error);
//                 });
//         },
//         formatDate(dateString) {
//             return new Date(dateString).toLocaleDateString('en-US');
//         }
//     }
// });


