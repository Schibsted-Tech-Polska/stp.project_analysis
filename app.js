
/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , http = require('http')
  , path = require('path')
  , projectMetainfo = require('./routes/input/projectMetainfo')
  , paths = require('./custom_modules/paths')
  , validator = require("validator");;


var app = express();

// all environments
app.set('port', process.env.PORT || paths.getPort());
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.set('input', __dirname + '/public/input');
console.log("dirname : " + __dirname);
app.use(validator);
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static(paths.locationOfFolderWithProjects()));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.get('/', routes.index);

app.get('/qualityAnalysis', projectMetainfo.form );
app.post('/qualityAnalysis', projectMetainfo.submit(app.get('qualityAnalysis')));


http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
