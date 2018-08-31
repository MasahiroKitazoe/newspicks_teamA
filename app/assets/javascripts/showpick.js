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


  // レスポンシブ対応
  var windowWidth = $(window).width();
  // windowWidthが1300px以下条件分岐
  if (windowWidth < 1250) {
    $('.side-bar').css("display", "none");
    $('.content').css("width", "100vw");
    $('.content__eyecatch__main').css("width", "100vw");
    $('.content__eyecatch__sub').css("display", "none");
    $('.content__top-news__newest').css("display", "none");
    $('.content__top-news__side-news').css("width", "100vw");
  }

  // リサイズで1300px以下になた時の条件分岐


});
