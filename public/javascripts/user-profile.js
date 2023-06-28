function implementChangesOnPage(){

    let req = new XMLHttpRequest();

    req.onreadystatechange = function(){
      if (req.readyState == 4 && req.status == 200){

        var user_details = JSON.parse(req.responseText).user;
        console.log(user_details);
        let username = user_details.username;

        let welcomeMessage = document.getElementById('welcome-message');
        if (username && welcomeMessage) {
        welcomeMessage.innerText = "Welcome, " + username + "!";
        welcomeMessage.style.color = "white";
        }
        let username_placeholder = document.getElementById('username-placeholder')
        username_placeholder.innerText = username;
        username_placeholder.style.display = 'inline-block';

        const email = user_details.email;
        const address = "Adelaide Uni";
        const given_name = user_details.given_name;
        const last_name = user_details.last_name;
        const id = user_details.user_id;

        let email_placeholder = document.getElementById('email-placeholder');
        email_placeholder.innerText = email;
        email_placeholder.style.display = 'inline-block';

        let address_placeholder = document.getElementById('address-placeholder');
        address_placeholder.innerText = address;
        address_placeholder.style.display = 'inline-block';

        let name_placeholder = document.getElementById('name-placeholder');
        name_placeholder.innerText = given_name + ' ' + last_name;
        name_placeholder.style.display = 'inline-block';

        let id_placeholder = document.getElementById('id-placeholder');
        id_placeholder.innerText = id;
        id_placeholder.style.display = 'inline-block';
      }
    }

    req.open('GET', '/get-user-details' );
    req.send();
}

// function customizeUserProfile(user){
//     // Check if the user exists
//     if (user) {
//         // two ways to retrieve json data

//         const email = user.email;
//         const address = user['address'];
//         const given_name = user.given_name;
//         const last_name = user.last_name;
//         const id = user.user_id;

//         let email_placeholder = document.getElementById('email-placeholder');
//         email_placeholder.innerText = email;
//         email_placeholder.style.display = 'inline-block';

//         let address_placeholder = document.getElementById('address-placeholder');
//         address_placeholder.innerText = address;
//         address_placeholder.style.display = 'inline-block';

//         let name_placeholder = document.getElementById('name-placeholder');
//         name_placeholder.innerText = given_name + ' ' + last_name;
//         name_placeholder.style.display = 'inline-block';

//         let id_placeholder = document.getElementById('id-placeholder');
//         id_placeholder.innerText = id;
//         id_placeholder.style.display = 'inline-block';

//     }
// }

// function retrieveAllUserDetails(username) {
//     let req = new XMLHttpRequest();

//     req.onreadystatechange = function() {
//         if (req.readyState == 4 && req.status == 200) {
//             var response = JSON.parse(this.responseText);
//             // Perform any necessary actions with the response data
//             console.log(response);
//             const user = response[username];
//             console.log(user);
//             customizeUserProfile(user);
//         }
//     };

//     req.open('GET', `profile/${username}`);
//     req.send();
// }
