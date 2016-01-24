//require modules
var express = require('express');
var http = require('http');
var https = require('https');

var path = require('path');
var fs = require('fs');
var bodyParser = require('body-parser');
var Parse = require('parse/node');

//set up
var app = express();
var httpServer = http.Server(app);
Parse.initialize("2yXRH3UsuqW18GwIQUvTvXbmagRohD6htD0oWcez", "kZHQ6yddT9ktlLJCy7sjQnLfgNyAcCOFDHpTb8Ze");

var port = process.env.PORT || 3000;


//middle ware
function log(req, res, next) {
  console.log('req: '+req.originalUrl);
  next();
}

app.use(express.static(path.join(__dirname, '/public')));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.use(log);


//routing
app.get('/all-posting', function(req, res) {
  var posting = Parse.Object.extend("Listing");
  var query = new Parse.Query(posting);
  query.include('book');
  query.find({
    success: function(results) {
      var resObjects = [];
      console.log("Successfully retrieved " + results.length + " posts.");
      // Do something with the returned Parse.Object values
      for (var i = 0; i < results.length; i++) {
        var object = results[i];
        var book = object.get('book');
        var title = book.get('bookName');
        var author = book.get('Author');
        var edition = book.get('Edition');
        var obj = {
          title: title,
          edition: edition,
          author: author
        };
        console.log(obj);
        resObjects.push(obj);
      }
      var string = JSON.stringify(resObjects);
      console.log(string);
      res.end(string);
    },
    error: function(error) {
      console.log("Error: " + error.code + " " + error.message);
    }
  });
});

app.get('/all-requests', function(req, res) {
  var posting = Parse.Object.extend("Request");
  var query = new Parse.Query(posting);
  query.include('forBook');
  query.find({
    success: function(results) {
      var resObjects = [];
      console.log("Successfully retrieved " + results.length + " posts.");
      // Do something with the returned Parse.Object values
      for (var i = 0; i < results.length; i++) {
        var object = results[i];
        var book = object.get('forBook');
        var title = book.get('bookName');
        var author = book.get('Author');
        var edition = book.get('Edition');
        var obj = {
          title: title,
          edition: edition,
          author: author
        };
        console.log(obj);
        resObjects.push(obj);
      }
      var string = JSON.stringify(resObjects);
      console.log(string);
      res.end(string);
    },
    error: function(error) {
      console.log("Error: " + error.code + " " + error.message);
    }
  });
});


//start server
httpServer.listen(port, function() {
	console.log('listening on port: ' + port);
});

process.on('SIGINT', function() {
  process.exit();
});

process.on('exit', function (){
  console.log('Goodbye!');
});
