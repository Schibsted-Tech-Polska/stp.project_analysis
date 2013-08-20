// $(document).ready(function() {
//     $('.language').click(function() {

//       var lang = $(this).attr('data-lang');
//       console.log('click' + lang);

//       $(this).addClass('active');
//       $(this).siblings().removeClass('active');

//       if (lang) {
//        //do something with lang
//       }
//     });
//   });

$(function () {
    $(".language-choice").change(function() {
      var val = $(this).val();
      console.log('val : ' + val);
      changeSelectLanguage(val);
    });

});

function changeSelectLanguage(val){
  console.log('changeSelectLanguage to ' + val);
  $('#targetLanguage').val(val);
      if(val === "java") {
          $('[name=javaBuildCommand]').show();
          $('[name=binaries]').show();
      }
      else {
          $('[name=javaBuildCommand]').hide();
          $('[name=binaries]').hide();
          $('[name=javaBuildCommand]').val('');
          $('[name=binaries]').val('');
      }
    selectCheckbox(val);
}
function selectCheckbox(val){
  var radios = $('input:radio[name=targetLanguage]');
  radios.filter('[value='+val+']').prop('checked', true);
}

function checkPreviousValues(){
   var inputsToCheck = ['gitCommand', 'javaBuildCommand',
                       'sources', 'binaries', 'filesToOmit', 'link'];
   inputsToCheck.map(function(current){
    checkSpecyficValue(current);
   });
   selectLanguage('targetLanguage');
}

function selectLanguage(nameOfElement){
  var previousValue = getPreviousValue(nameOfElement);
  console.log('lang : ' + previousValue)
  var tool = getPreviousValue('analysisTool');
  console.log('tool : ' + tool);
  console.log('previousValue : ' + previousValue);
  if(previousValue == 'js'){
    changeSelectLanguage([previousValue, tool].join('-'));
  }else if(previousValue === 'undefined'){
    changeSelectLanguage('java');
  }else{
    changeSelectLanguage(previousValue);
  }
}

function checkSpecyficValue(nameOfElement){
  var previousValue = getPreviousValue(nameOfElement);
  if(!isUndefinedOrEmpty(previousValue)){
    $('[name='+nameOfElement+']').val(previousValue);
  }
}
function isUndefinedOrEmpty(val){
  return val === 'undefined' || val === '';
}


 function getPreviousValue(nameOfElement){
    var elem = document.getElementsByName(nameOfElement)[0];
    return elem.dataset[ 'project' ];
  }

  function clearLinkInput(){
    var linkVal = $('[name=link]').val();
    if(linkVal.indexOf('function') !== -1){
      $('[name=link]').val('');
    }
  }



  window.onload = checkPreviousValues();
  window.onload = clearLinkInput();
