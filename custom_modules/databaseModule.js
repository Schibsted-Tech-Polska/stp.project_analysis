/*var mongodb = require('mongodb');
var server = new mongodb.Server('127.0.0.1', 27017, {});

var client = new mongodb.Db('pa', server);

exports.addNewAnalysis = function(projectId){
	client.open(function(err,db){
		if(err)
			console.log('cant open client');
		db.collection('analyses', function(err, collection){
			if (err) 
				console.log('error when inserting client.collection');
			collection.insert(
				{"projectId": projectId},
				{safe:true},
				function(err,documents) {
					if(err)
						console.log('error while inserting : ' + projectId);
					var documentId = documents[0]._id;
					var _id = new client.bson_serializer.ObjectID(documentId);
					console.log("id of inserted data : " + _id);
				});

		});
	});


}*/

//to start mongodb in shell mongod
var Db = require('mongodb').Db;
var Server = require('mongodb').Server;
var db = new Db('pa', new Server('localhost', 27017));

exports.addNewAnalysis2 = function(projectId){
	db.open(function(err,db){
		if(err)
			console.log('error while open db');
		var collection = db.collection('collection_of_analysis');
		collection.insert(
					{"projectId": projectId},
					{safe:true},
					function(err,documents) {
						if(err)
							console.log('error while inserting : ' + projectId);
						var documentId = documents[0]._id;
						//var _id = new client.bson_serializer.ObjectID(documentId);
						console.log("id of inserted data : " + documentId);
					});
	});
	db.close();
	/*setTimeout(function() {
	// Fetch the document
  		collection.findOne({hello:'world_no_safe'}, function(err, item) {
   			
  		})
	}, 100);
	*/

/*
	var mysql      = require('mysql');
	var connection = mysql.createConnection({
	  host     : 'localhost',
	  user     : 'me',
	  password : 'secret',
	});

	connection.connect();

	connection.query('SELECT 1 + 1 AS solution', function(err, rows, fields) {
	  if (err) throw err;

	  console.log('The solution is: ', rows[0].solution);
	});

	connection.end();*/
}