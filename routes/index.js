const express = require('express');
const router = express.Router();
var argon2 = require('argon2');
var nodemailer = require('nodemailer');

// console.log('here');

const CLIENT_ID = '662332526811-njof4qvcg29cpvr4f787kjef1b22395j.apps.googleusercontent.com';
const {OAuth2Client} = require('google-auth-library');
const session = require('express-session');
const client = new OAuth2Client(CLIENT_ID);

/* GET home page. */
router.get('/', function(req, res, next) {
  // console.log('/');
  res.render('index');
});

// testing purposes: username: prags, password: foobar
// username: charlie, password: pass
// kieron, westindies
// virat, india
// willy, holly
// Implement a login functionality that authenticates the user's credentials and establishes a session. This typically involves verifying the username and password against a database or user store, setting the session state, and generating a session ID or token.
// note: myprofile will not show account details for logins with google rn
// let users = {
//   pragya: {
//     password: 'pass',
//     usertype:'user',
//     email: 'example@gmail.com',
//     address: '34 Tanah Merah Kechil Rd',
//     name: 'Pragya Kaushik',
//     id: '123456'
//   },
//   simran: {
//     password: 'hi',
//     usertype:'club-manager',
//     email: 'example@gmail.com',
//     address: 'Adelaide SA 5005',
//     name: 'Simranjeet',
//     id: '987654',
//     club: 'Quantum Computing Club'
//   },
//   victor: {
//     password: 'hello',
//     usertype:'admin',
//     email: 'example@gmail.com',
//     address: 'Adelaide SA 5005',
//     name: 'Victor',
//     id: '345678'
//   }
// }

router.post('/login', async function(req, res, next) {
  if ('client_id' in req.body) {
    // Using Google's public key to decrypt and verify the user
    const ticket = await client.verifyIdToken({
      idToken: req.body.credential,
      audience: CLIENT_ID,
      // Specify the CLIENT_ID of the app that accesses the backend
      // Or, if multiple clients access the backend:
      // [CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3]
    });

    const payload = ticket.getPayload();
    const user_email = payload['email'];
    console.log(payload['email']);

    req.pool.getConnection(function(cerr, connection) {
      if (cerr) {
        res.sendStatus(500);
        return;
      }

      var query = "SELECT * FROM users WHERE email = ?;";

      connection.query(query, user_email, async function (qerr, result) {
        connection.release();
        if (qerr) {
          res.sendStatus(500);
          return;
        }
        if (result.length > 0) {
          // There is a user with this email
          var user = result[0];
          req.session.user = user;
          console.log(req.session.user);
          req.session.isAuthenticated = true;
        } else {
          // No user with this email
          res.sendStatus(401);
        }

        res.end();
      });
    });
  } else {
    // else if we are dealing with a regular login
    req.pool.getConnection((cerr, connection) => {
      if (cerr) {
        console.error('Error connecting to database: ', cerr);
        res.sendStatus(401);
        return;
      }
      var query = "SELECT * FROM users WHERE username = ?;";
      values = req.body.username;
      connection.query(query, values, async (err1, result) => {
        connection.release();
        if (err1) {
          console.error('Error retrieving user: ', err1);
          res.sendStatus(401);
          return;
        }

        if (result.length === 0) {
          console.error('Invalid credentials');
          res.sendStatus(401);
          return;
        }

        var user = result[0];

        try {
          if (await argon2.verify(user.password_hash, req.body.password)) {
            // password match
            req.session.user = user; // need to figure out a way to do so for google as well
            req.session.isAuthenticated = true;
            // console.log(req.body.username);
            // Send the username back to the client in the response

            console.log(req.session.user);

            // res.json({ username: req.body.username, usertype: user.user_type });
            // res.json({user: req.session.user});

            res.end();
            // return;

          } else {
            // password did not match
            console.error('Error comparing passwords: ', compareError);
            res.sendStatus(401);
            return;

          }
        } catch (err) {
          // internal failure
          res.sendStatus(401);
          return;
        }
      });
    });
  };
});


router.post('/signup', async function(req, res, next){
  // console.log('here');
  var { username, firstname, lastname, email, password } = req.body;

  var password_hash = null;
  try {
    password_hash = await argon2.hash(password);
  } catch (err) {
    res.sendStatus(500);
    return;
  }

  // console.log(username);
  // console.log(email);
  // console.log(password);

  req.pool.getConnection((err, connection) => {
    if (err) {
      console.error('Error connecting to database: ', err);
      res.sendStatus(401);
      return;
    }

    var query = "INSERT INTO users (user_type, username, given_name, last_name, email, password_hash) VALUES ('user', ?, ?, ?, ?, ?);";
    // console.log('hello');
    values = [username, firstname, lastname, email, password_hash];
    connection.query(query, values, (err1, result) => {
      connection.release();
      if (err1) {
        if (err1.code = 'ER_DUP_ENTRY') {
          console.error('Username already exists');
          res.sendStatus(401);
          return;
        }

        console.error('Error creating user: ', err1);
        res.sendStatus(401);
        return;
      }

      // const hash = await argon2.hash(req.body.password);

      // console.log('here');

      let user_details = {
        username: req.body.username,
        user_type: 'user',
        given_name: req.body.firstname,
        last_name: req.body.lastname,
        email: req.body.email
      };
      req.session.user = user_details;
      req.session.isAuthenticated = true;
      // users[req.body.username] = {password: req.body.password, email: req.body.email, usertype: 'user', address: 'Adelaide Uni', name: '', id:''};
      // console.log(users[req.body.username]);
      console.log(req.session.user);
      // res.json({user: req.session.user});
      res.end();
      // res.json(rows);
    });
  });
});

// events
router.get('/events', (req, res) => {
  req.pool.getConnection((err, connection) => {
    if (err) {
      console.error('Error connecting to the database:', err);
      res.status(500).json({ error: 'Database error' });
      return;
    }

    const query = 'SELECT * FROM events';

    connection.query(query, (err, rows, fields) => {
      connection.release();

      if (err) {
        console.error('Error executing the query:', err);
        res.status(500).json({ error: 'Database error' });
        return;
      }

      res.json(rows);
    });
  });
});

/*********** Above is not gated by login. It's available to all users *************/

router.use('/', function(req, res, next){
  if (!(req.session.isAuthenticated)){
    res.sendStatus(403);
  } else{
    next();
  }
});

/************* Every route below requires a login ***************/

router.get('/get-user-details', function(req, res, next){
  res.json({user: req.session.user});
  res.end();
});

router.get('/logout', function(req, res, next){
  if ('user' in req.session){
    delete req.session.user;
    delete req.session.isAuthenticated;
    res.end();
  } else{
    res.sendStatus(403);
  }
});

router.get('/profile/:username', function(req, res, next) {
  req.pool.getConnection((err, connection) => {
    if (err) {
      res.sendStatus(401);
      return
    }

    var query = "SELECT user_id, user_type, given_name, last_name, email FROM users WHERE username = ?;"

    username = req.params.username;

    connection.query(query, username, (err1, result) => {
      connection.release();
      if (err1) {
        res.sendStatus(401);
        return;
      }

      if (result.length === 0) {
        res.sendStatus(401);
        return;
      }

      user = result[0];

      res.json({ [username]:user });
    });
  });
});

// router.get('/events/:username', function(req, res, next) {
//   res.end();
// });

let transporter = nodemailer.createTransport({
  host: 'smtp.ethereal.email',
  port: 587,
  auth: {
    user: 'meaghan.rath40@ethereal.email',
    pass: 'S9gfPy7PPjwZZqdAux'
  }
});

var attendees = ['iampragyakaushik@gmail.com'];

router.post('/rsvp', function(req, res, next){
  attendees.push(req.session.user.email);
  console.log("attendee email:" + req.user.email);
  res.end();
});

router.post('/email', function(req, res, next){
  let info = transporter.sendMail({
    from: 'meaghan.rath40@ethereal.email', // sender email
    to: attendees,
    subject: req.body.subject,
    text: req.body.text,
    html: "<b>" + req.body.text + "/<b>"
  });
  res.send();
  res.end();
});

router.post('/create-event', function(req, res, next) {
  req.pool.getConnection((err, connection) => {
    if (err) {
      console.error('Error connecting to database: ', err);
      res.sendStatus(401);
      return;
    }

    var query = `INSERT INTO events (event_name, club_id, event_datetime, cost, contact_email, event_description, expiry)
                  VALUES (?, 1, ?, 0.00, 'event1@example.com', ?, '2023-06-30 00:00:00');`;

    var values = [req.body.name, req.body.date, req.body.text];
    connection.query(query, values, (err1, result) => {
      connection.release();
      if (err1) {
        console.error('Error creating event: ', err1);
        res.sendStatus(501);
        return;
      }

      // Check if any rows were affected by the INSERT query
      if (result.affectedRows > 0) {
        console.log('Event created successfully');
        // You can also access the generated event ID if needed: result.insertId
        // Send a response indicating success
        res.sendStatus(200);
      } else {
        console.log('No event created');
        // Send a response indicating failure
        res.sendStatus(500);
      }
    });
  });
});



module.exports = router;