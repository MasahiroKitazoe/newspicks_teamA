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
    if($('.comment-menu .popover').css('display') == 'none') {
      $('.popover').css('display', 'block');
    }
  });

  // current_userのコメント欄で編集・削除ボタンがある時その他のコメント欄をクリックした場合に非表示
  $('.news-comment').on('click',function(e) {
    if(!$(e.target).closest('.menu-btn').length && $('.comment-menu .popover').css('display') == 'block') {
      e.preventDefault();
      $('.comment-menu .popover').css('display', 'none');
    };
  })

// 編集ボタンをクリックすることで編集画面を表示。
  $('.comment-edit-btn').on('click', function(e) {
    e.preventDefault();
    $('.comment-wrapper').css('display', 'none');
    $('.embedded-pick-editor').css('display', 'block');
  })

// 編集ボタンを押した後に、キャンセルをクリックすると編集画面を閉じる。
  $('.cancel-wrapper').on('click', function(e) {
    e.preventDefault();
    $('.comment-wrapper').css('display', 'block');
    $('.embedded-pick-editor').css('display', 'none');
  })



  $('.side-bar__my-news').on("click", function() {
    console.log('hello')
  })
  $('.drop-down-button').on("click", function() {
    console.log('hello!')
  })
});
