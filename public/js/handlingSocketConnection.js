  
  function handleConnection(){
     var numberOfStates = 3;
     var nameOfGitRepo = getNameOfRepo();
     var socket = io.connect();


    socket.emit('getStatus', {'nameOfGitRepo': nameOfGitRepo});

    
    socket.on('statusChanged', function (data) {
      if(data){
        console.log(data);
        console.log('clientSide result: ' + data);
        
        var linkToAnalyzedProject = data.linkToAnalyzedProject;
        
        setDataInElement(data.status + " of 3 steps", 'result');
        appendDataToElement(data.log, 'log');
        console.log('size:' +  roughSizeOfObject(data.log));
        var interval = 1000;

        if(data.status === numberOfStates){
        	projectAnalysisReady(linkToAnalyzedProject);
        }else{
          setTimeout(function(){
            socket.emit('getStatus', {'nameOfGitRepo': nameOfGitRepo});
          }, interval );
        }

      }
     
      
    });
  }

  function getNameOfRepo(){
    var elem = document.getElementById('nameOfGitRepo');
    return elem.dataset[ 'project' ];
  }

  function appendDataToElement(dataToSet, idOfElem){
    var elem = document.getElementById(idOfElem);
    //var txt=document.createTextNode(dataToSet);
    elem.value = dataToSet;
    //elem.appendChild(txt);
  }

  	
  function setDataInElement(dataToSet, idOfElem){
  	console.log('setDataInDiv :' + dataToSet);
  	var div = document.getElementById(idOfElem);
  	div.innerHTML = dataToSet ;
  }

  function projectAnalysisReady(linkToAnalyzedProject){
    var progressbar = document.getElementsByClassName('progressbar')[0];
    progressbar.style.display = 'none';
    var aWithLinkToAnalyzedProject = document.getElementById('linkToAnalyzedProject');
    aWithLinkToAnalyzedProject.href = linkToAnalyzedProject;
    aWithLinkToAnalyzedProject.innerHTML = 'link to your result';
  }

function roughSizeOfObject( object ) {

    var objectList = [];
    var stack = [ object ];
    var bytes = 0;

    while ( stack.length ) {
        var value = stack.pop();

        if ( typeof value === 'boolean' ) {
            bytes += 4;
        }
        else if ( typeof value === 'string' ) {
            bytes += value.length * 2;
        }
        else if ( typeof value === 'number' ) {
            bytes += 8;
        }
        else if
        (
            typeof value === 'object'
            && objectList.indexOf( value ) === -1
        )
        {
            objectList.push( value );

            for( i in value ) {
                stack.push( value[ i ] );
            }
        }
    }
    return bytes;
}

window.onload = handleConnection;  