$(function() {
  $('#news-recommendation-btn').on('click', function(e){
    user_id = $(this).attr('data')
    $.ajax('https://gentle-tundra-41702.herokuapp.com/api/' + user_id + '/')
      .done(function(data) {
        console.log(user_id)
      })
      .fail(function(data) {
      });
    e.preventDefault();
  });
});
