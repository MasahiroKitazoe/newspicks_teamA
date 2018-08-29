$(function() {
  $("#comment-space").focusin(function(e) {
    $(this).css("width", "480px");
  });
  $("#comment-space").focusout(function(e) {
    $(this).css("width", "284px");
  });

  $(document).on('ajax:complete', '.new_comment', function(event, ajax, status){
    var response;
    response = $.parseJSON(ajax.responseText);
    $('.followings').append(response.html);
    $('form')[0].reset();
  });

  $('.side-bar__my-news').on("click", function() {
    console.log('hello')
  })
  $('.drop-down-button').on("click", function() {
    console.log('hello!')
  })
});
