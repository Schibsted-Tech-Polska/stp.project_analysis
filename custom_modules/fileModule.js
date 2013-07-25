var fs = require('fs');
var paths = require('../custom_modules/paths.js');
var logger = require('winston');
var nameOfModule = 'fileModule';

exports.buildAbsolutePath = function(nameOfFile){
  var locationOfFolderWithProjects = paths.locationOfFolderWithProjects();
  return [locationOfFolderWithProjects,nameOfFile].join('/');
}

exports.copyFile = function(source, target, cb) {
  var cbCalled = false;

  var rd = fs.createReadStream(source);
  rd.on("error", function(err) {
    done(err);
  });
  var wr = fs.createWriteStream(target);
  wr.on("error", function(err) {
    done(err);
  });
  wr.on("close", function(ex) {
    done();
  });
  rd.pipe(wr);

  function done(err) {
    if (!cbCalled) {
      cb(err);
      cbCalled = true;
    }
  }
}


exports.copyFileAndChangeProperties = function(source, target,propertiesToChange, callback ){
  readTextFileAndModifyContent(source,target,propertiesToChange, writeAndCall(callback));
}



readTextFileAndModifyContent = function(source, target, propertiesToChange,cb){
  fs.readFile(source, 'utf8', function (err,data) {
      if (err) {
       return logger.info(nameOfModule, 'readTextFileAndModifyContent FAILED, err : ' + err);
   }
   
   var stringData = data.toString();
   var replaced;  
   for(var property in propertiesToChange){
      replaced = stringData.replace(property, propertiesToChange[property]);
      stringData = replaced;
   }
     cb(target,replaced);
    
  });

}


writeTextFile = function(path, data, callback){
 fs.writeFile(path, data, function(err) {
    if(err) {
        logger.info(nameOfModule, 'writingTextFile FAILED err :' + err +' ,data : ' + data);
    } else {
        logger.info(nameOfModule, 'sucesfully saved properties file at path : ' + path);
    }
    callback();
  });
}

var writeAndCall = function(callback){
  return function(path, data){
    writeTextFile(path, data, callback);
  }
}

exports.deleteFolder = function(path){
  return function(){ 
    deleteFolderRecursive(path);
  }
  
}

var deleteFolderRecursive =  function(path) {
  
  if( fs.existsSync(path) ) {
    fs.readdirSync(path).forEach(function(file,index){
      var curPath = path + "/" + file;
      if(fs.statSync(curPath).isDirectory()) { // recurse
        deleteFolderRecursive(curPath);
      } else { // delete file
        fs.unlinkSync(curPath);
      }
    });
    fs.rmdirSync(path);
  }

}


exports.extractDirectoryFromPath = function(path){
  var array = path.split('/');
  array.pop();
  return array.join('/');

}

