var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});




/*********** Above is not gated by login. It's available to all users *************/

router.use('/', function(req, res, next){
  if (!('username' in req.session)){
    res.sendStatus(403);
  } else{
    next();
  }
});

/************* Every route below requires a login ***************/


module.exports = router;