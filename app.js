
/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , http = require('http')
  , path = require('path')
  , projectMetainfo = require('./routes/input/projectMetainfo')
  , paths = require('./custom_modules/paths')
  , projectStatus = require('./routes/projectStatus')
  , datastoreModule = require('./custom_modules/datastoreModule')
  //, swgger = require('swagger-node-express')
  , envInformationModule = require('./custom_modules/envInformationModule')
  , models = require('./custom_modules/models');
 // , validator = require("validator")
  //, mongodb = require('mongodb');




var app = express();

// all environments
app.set('port', process.env.PORT || paths.getApplicationPort());
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.set('input', __dirname + '/public/input');
console.log("dirname : " + __dirname);
//app.use(validator);
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static(paths.locationOfFolderWithProjects()));
GLOBAL.PROGRESS_STATUS = [];
//GLOBAL.PROJECT_ID = 0;

// development only
//if ('development' == app.get('env')) {
//  app.use(express.errorHandler());
//}

app.configure(function(){
  envInformationModule.setHostname(GLOBAL);
  console.log('set for all environments');
  app.use(express.errorHandler()); 
});

/*
app.configure('development', function(){
  GLOBAL.serverPath = 'localhost';
  console.log('set for development');
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true })); 
});

app.configure('production', function(){
  envInformationModule.setHostname(GLOBAL);
 //console.log('sp : ' + GLOBAL.serverPath);
  console.log('set for production');
  app.use(express.errorHandler()); 
});*/



//app.get('/', routes.index);
app.get('/projectStatus/:id', projectStatus.status );
app.get('/projectStatus', projectStatus.allStatuses);
app.get('/', projectMetainfo.form );
app.post('/', projectMetainfo.submit(app.get('/')));


var server = http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});

var io = require ('socket.io').listen(server);
io.set('log level', 1);

io.sockets.on('connection', function(socket){
	socket.on('getStatus', function(data){
		var record = datastoreModule.getRecordForProjectName(data.nameOfGitRepo);
		socket.emit('statusChanged', record );
	});
});

//swgger.addModels(models);


