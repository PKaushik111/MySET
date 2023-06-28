var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var session = require('express-session');
var mysql = require('mysql');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use(session({
    resave: false,
    saveUninitialized: true,
    secret: 'super secret string',
    secure: false
}));

var dbConnectionPool = mysql.createPool({
    host: 'localhost',
    database: 'myset'
});

app.use((req, res, next) => {
    req.pool = dbConnectionPool;
    next();
})

// please don't comment this section: we need for sessions
app.use(session({
    resave: false,
    saveUninitialized: true,
    secret: 'what is this',
    secure: false
}));

app.use(function(req, res, next) {
    if ('user' in req.session){
        console.log("The current user is: "+ req.session.user.username);
    } else{
        console.log("The current user is: undefined");
    }
    next();
});

app.use(express.static(path.join(__dirname, 'public')));

// // Define a route for serving the index.html page
// app.get('/custom-index', function(req, res) {
//     // Send the index.html file as the response
//     res.sendFile('public/custom-index.html', { root: __dirname });
// });

app.use('/', indexRouter);
app.use('/users', usersRouter);

app.all('*',(req, res) => {
    res.status(404).send('<h1>Error 404 page not found<h1>');
});

module.exports = app;
