
function customizeHomePage() {
  window.location.assign('index.html?loggedIn=true');
}

function implementChangesToHome(){

  let req = new XMLHttpRequest();

  req.onreadystatechange = function(){
    if (req.readyState == 4 && req.status == 200){

      var user_details = JSON.parse(req.responseText).user;
      console.log(user_details);
      let username = user_details.username;
      let usertype = user_details['user_type'];

      let welcomeMessage = document.getElementById('welcome-message');
      if (username && welcomeMessage) {
      welcomeMessage.innerText = "Welcome, " + username + "!";
      welcomeMessage.style.color = "white";
      }

      if (usertype == 'user'){
        document.getElementById('text-1').innerText = "Hi " + username + ", you are a mySET member."
        document.getElementById('access-specific-button').innerHTML = `<button type="button" id="access-specific-button" onclick="window.location.href='myprofile.html?loggedIn=true';">MyProfile</button>`;
        let nav_bar = document.getElementsByClassName('nav-bar')[0];
        let newLink = document.createElement('a');
        newLink.href = 'myprofile.html?loggedIn=true'; // Replace 'my-profile.html' with your custom URL
        newLink.textContent = 'MY-PROFILE';
        nav_bar.appendChild(newLink);
      } else if (usertype == 'club-manager'){
        document.getElementById('text-1').innerText = "Hi " + username + ", you are a club manager."
        document.getElementById('access-specific-button').innerHTML = `<button type="button" id="access-specific-button" onclick="window.location.href='manager.html?loggedIn=true';">Manage Club</button>`;
        let nav_bar = document.getElementsByClassName('nav-bar')[0];
        let newLink = document.createElement('a');
        newLink.href = 'manager.html?loggedIn=true';
        newLink.textContent = 'MANAGE-CLUB';
        nav_bar.appendChild(newLink);
      } else if (usertype == 'admin'){
        document.getElementById('text-1').innerText = "Hi " + username + ", you are an admin."
        document.getElementById('access-specific-button').innerHTML = `<button type="button" id="access-specific-button" onclick="window.location.href='admin.html?loggedIn=true';">Admin Page</button>`;
        let nav_bar = document.getElementsByClassName('nav-bar')[0];
        let newLink = document.createElement('a');
        newLink.href = 'admin.html?loggedIn=true';
        newLink.textContent = 'ADMIN-PAGE';
        nav_bar.appendChild(newLink);
      }
    } else if (req.readyState == 4 && req.status == 401){
      alert('FAILED to load custom home page');
    }
  };

  req.open('GET', '/get-user-details' );
  req.send();
}

function uncustomizeHomePage() {
  window.location.assign('index.html');
}

function login(event) {
  event.preventDefault();

  let logindata = {
    username: document.getElementById('login-user').value,
    password: document.getElementById('login-pass').value
  }

  let req = new XMLHttpRequest();

  req.onreadystatechange = function(){
    if (req.readyState == 4 && req.status == 200) {
      // redirect to customized HOME page
      // window.location.assign('index.html');
      // var response = JSON.parse(req.responseText);
      // var username = response.username;
      // var usertype = response.usertype;
      customizeHomePage();
      alert('Logged In successfully');
    } else if (req.readyState == 4 && req.status == 401){
      alert('Wrong Password. Login FAILED');
      return;
    }
  };

  req.open('POST', '/login' );
  req.setRequestHeader('Content-Type', 'application/json');
  req.send(JSON.stringify(logindata));
}


function signup(event){
  event.preventDefault();

  let signupdata = {
    username: document.getElementById('signup-user').value,
    firstname: document.getElementById('signup-firstname').value,
    lastname: document.getElementById('signup-lastname').value,
    email: document.getElementById('signup-email').value,
    password: document.getElementById('signup-pass').value
  }

  if (document.getElementById('signup-pass').value !== document.getElementById('signup-confirm').value){
    alert("Passwords don't match");
    return;
  }

  let req = new XMLHttpRequest();

  req.onreadystatechange = function(){
    if (req.readyState == 4 && req.status == 200){
      // render customised home page
      // var user_details = JSON.parse(req.responseText);
      customizeHomePage();
      alert('Signed Up successfully');
    } else if (req.readyState == 4 && req.status == 401){
      alert('Sign Up FAILED. Choose a unique password and email.');
    }
  };
  req.open('POST', '/signup' );
  req.setRequestHeader('Content-Type', 'application/json');
  // console.log(signupdata);
  req.send(JSON.stringify(signupdata));
}

// Client ID: 662332526811-njof4qvcg29cpvr4f787kjef1b22395j.apps.googleusercontent.com
// function to handle after signin: do_google_login

function do_google_login(response){
  console.log(response);

  let req = new XMLHttpRequest();

  req.onreadystatechange = function(){
    if (req.readyState == 4 && req.status == 200){
      // var response = JSON.parse(req.responseText);
      // var username = response.username;
      // var usertype = response.usertype;
      customizeHomePage();
      alert('Logged In with Google successfully');
    } else if (req.readyState == 4 && req.status == 401){
      alert('Login through Google FAILED');
    }
  };

  req.open('POST', '/login' );
  req.setRequestHeader('Content-Type', 'application/json');
  req.send(JSON.stringify(response));
}

function logout(){
  let req = new XMLHttpRequest();

  req.onreadystatechange = function(){
    if (req.readyState == 4 && req.status == 200){
      uncustomizeHomePage();
      alert('You have Logged Out')
    } else if (req.readyState == 4 && req.status == 401){
      alert('Not Logged In')
    }
  };
  req.open('GET', '/logout');
  req.send();
}

// // Google login button click event
// document.querySelector('.google-btn').addEventListener('click', function() {
//   // Perform Google login functionality
//   window.location.href = 'https://accounts.google.com'; // Redirect to Google login page
// });

// // Facebook login button click event
// document.querySelector('.facebook-btn').addEventListener('click', function() {
//   // Perform Facebook login functionality
//   window.location.href = 'https://www.facebook.com'; // Redirect to Facebook login page
// });

// // Apple ID login button click event
// document.querySelector('.apple-btn').addEventListener('click', function() {
//   // Perform Apple ID login functionality
//   window.location.href = 'https://appleid.apple.com'; // Redirect to Apple ID login page
// });

// // document.getElementById("google-login").addEventListener("click", function() {
// //   window.location.href = "login.html";
// // })