$(function() {
  // コメント入力時に画面を大きく
  $("#comment-space").focusin(function(e) {
    e.preventDefault();
    $(this).css("width", "480px");
  });
  // コメント入力から離れた場合は画面を小さく
  $("#comment-space").focusout(function(e) {
    e.preventDefault();
    $(this).css("width", "284px");
  });

  // current_userのコメント欄で横のボタンをクリックした場合に表示
  $('.menu-btn').on('click', function(e){
    e.preventDefault();
    $('.popover').css('display', 'block');
  });
  // current_userのコメント欄で横のボタンをクリックした場合に表示
  // $('.news-comment').on('click', function(e) {
  //   console.log('hello')
  //   e.preventDefault();
  //   $('.popover').css('display', 'none');
  // });

  // $(document).on('click touchend', function(event) {
  //   if (!$(event.target).closest('.popover').length) {
  //     console.log('hello');
  //     $('.popover').css('display', 'none');
  //   }
  // });
  // if($('.popover').css('display') === 'block') {
  //   $('.news-comment').on('click', function(e) {
  //     console.log($('.popover').css('display'))
  //     console.log('hello')
  //     e.preventDefault();
  //     $('.popover').css('display', 'none');
  //   });
  // }
  $('.side-bar__my-news').on("click", function() {
    console.log('hello')
  })
  $('.drop-down-button').on("click", function() {
    console.log('hello!')
  })
});
