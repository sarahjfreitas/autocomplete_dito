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