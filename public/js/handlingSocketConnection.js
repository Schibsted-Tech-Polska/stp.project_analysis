  
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
        
        setDataInResultDiv(data.status);
        var interval = 8000;

        if(data.status === numberOfStates){
        	projectAnalysisReady(linkToAnalyzedProject);
          //window.location.href = linkToAnalyzedProject;
        }
      }
      setTimeout(function(){
      	socket.emit('getStatus', {'nameOfGitRepo': nameOfGitRepo});
      }, interval );
      
    });
  }

  function getNameOfRepo(){
    var elem = document.getElementById('nameOfGitRepo');
    return elem.dataset[ 'project' ];
  }

  	
  function setDataInResultDiv(dataToSet){
  	console.log('setDataInDiv :' + dataToSet);
  	var div = document.getElementById('result');
  	div.innerHTML = dataToSet + " of 3 steps" ;
  }

  function projectAnalysisReady(linkToAnalyzedProject){
    var progressbar = document.getElementsByClassName('progressbar')[0];
    progressbar.style.display = 'none';
    var aWithLinkToAnalyzedProject = document.getElementById('linkToAnalyzedProject');
    aWithLinkToAnalyzedProject.href = linkToAnalyzedProject;
    aWithLinkToAnalyzedProject.innerHTML = 'link to your result';
  }

window.onload = handleConnection;  