// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
$(document).ready(function(){
  $('#teste').select2({
    minimumInputLength: 2,
    ajax: {
      url: 'http://localhost:3001',
      dataType: 'json',
      delay: 200,
      cache: true,
      data: function(params){
        return { term: params.term }
      },
      processResults: function(data){
        return {
          results: $.map(data,function(obj){
            return {
              id: obj.id,
              text: obj.name
            }
          })
        };
      }
    }
  });
});