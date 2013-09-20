(function(){
  $(function () {
    var fileUploadErrors = {
      maxFileSize: 'File is too big',
      minFileSize: 'File is too small',
      acceptFileTypes: 'Filetype not allowed',
      maxNumberOfFiles: 'Max number of files exceeded',
      uploadedBytes: 'Uploaded bytes exceed file size',
      emptyResult: 'Empty file upload result'
    }

    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload();

    // Enable iframe cross-domain access via redirect option:
    $('#fileupload').fileupload(
      'option',
      'redirect',
      window.location.href.replace(
        /\/[^\/]*$/,
        '/cors/result.html?%s'
      )
    );

    $('#fileupload').fileupload('option', {
      maxFileSize:10000000,
      acceptFileTypes:/(\.|\/)(gif|jpe?g|png)$/i,
      sequentialUploads:true,
      process:[
        {
        action:'load',
        fileTypes:/^image\/(gif|jpeg|png)$/,
        maxFileSize:20000000 // 20MB
      },
      {
        action:'resize',
        maxWidth:2048,
        maxHeight:2048
      },
      {
        action:'save'
      }
      ]
    });
    /*
    if ($.support.cors) {
      $.ajax({
        url:'http://localhost:3000',
        type:'HEAD'
      }).fail(function () {
        $('<span class="alert alert-error"/>')
        .text('Upload server currently unavailable - ' +
              new Date())
        .appendTo('#fileupload');
      });
    }
    */
    // Load existing files:
    $('#fileupload').each(function () {
      var that = this;
      $.getJSON(this.action, function (result) {
        if (result && result.length) {
          $(that).fileupload('option', 'done')
          .call(that, null, {result:result});
        }
      });
    });
  });
}).call(this);
