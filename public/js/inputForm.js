$(function () {
    $("#targetLanguage").change(function() {
      var val = $(this).val();
      console.log('val : ' + val);
      if(val === "java") {
          $('[name=javaBuildCommand]').show();
          $('[name=sources]').show();
          $('[name=binaries]').show();
      }
      else {
        console.log('else')
          $('[name=javaBuildCommand]').hide();
          $('[name=sources]').hide();
          $('[name=binaries]').hide();
          $('[name=javaBuildCommand]').val('');
          $('[name=sources]').val('');
          $('[name=binaries]').val('');
          
      }
    });
  })
