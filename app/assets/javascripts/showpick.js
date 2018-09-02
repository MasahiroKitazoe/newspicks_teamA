$(function() {

// 入力画面に関するJavascript
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


// current_userのコメント欄に対するJavascript
  // current_userのコメント欄で横のボタンをクリックした場合に表示
  $('#user-comments').on('click', '.menu-btn', function(e){
    e.preventDefault();
    if($('.comment-menu .popover').css('display') == 'none') {
      $('.popover').css('display', 'block');
    }
  })

  // current_userのコメント欄で編集・削除ボタンがある時その他のコメント欄をクリックした場合に非表示
  $('.news-comment').on('click',function(e) {
    if(!$(e.target).closest('.menu-btn').length && $('.comment-menu .popover').css('display') == 'block') {
      e.preventDefault();
      $('.comment-menu .popover').css('display', 'none');
    };
  })

  // 編集ボタンをクリックすることで編集画面を表示。
  $('.followings').on('click','.comment-edit-btn', function(e) {
    console.log('hello')
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

// modal発生後に関するJavascript

  // 確認画面を見た後、キャンセルボタンを押した後元に戻る
  $('.modal-comment-confirm').on('click','.negative-button',function(e){
    e.preventDefault();
    $('.modal-comment-confirm').css('display', 'none');
    $(".message-box-edit").css('display', 'none');
    $(".message-box-delete").css('display', 'none');
  })

  // 編集をした後に元の画面に戻るように変更
  $(document).on('ajax:complete', '.edit_comment', function() {
    $('.modal-comment-confirm').css('display', 'none');
    $(".message-box-edit").css('display', 'none');
  });

  $('.side-bar__my-news').on("click", function() {
    console.log('hello')
  })
  $('.drop-down-button').on("click", function() {
    console.log('hello!')
  })


  // var windowWidth = $(window).width();
  // レスポンシブ対応
  // windowWidthが1300px以下条件分岐
  // if (windowWidth < 1250) {
  //   $('.side-bar').css("display", "none");
  //   $('.content').css("width", "100vw");
  //   $('.content__eyecatch__main').css("width", "100vw");
  //   $('.content__eyecatch__sub').css("display", "none");
  //   $('.content__top-news__newest').css("display", "none");
  //   $('.content__top-news__side-news').css("width", "100vw");
  // }

  $(window).on('load resize', function(){
  // 処理を記載
    var windowWidth = $(window).width();
    if (windowWidth < 1300) {
      $('.side-bar').css("display", "none");
      $('.content').css("width", "100vw");
      $('.content__eyecatch__main').css("width", "100vw");
      $('.content__eyecatch__sub').css("display", "none");
      $('.content__top-news__newest').css("display", "none");
      $('.content__top-news__side-news').css("width", "100vw");
    } else {
      $('.side-bar').css("display", "block");
      $('.content').css("width", "calc(85vw - 10px)");
      $('.content__eyecatch__main').css("width", "calc(55vw - 30px)");
      $('.content__eyecatch__sub').css("display", "block");
      $('.content__top-news__newest').css("display", "block");
      $('.content__top-news__side-news').css("width", "50vw");
    }
  });

  // リサイズで1300px以下になた時の条件分岐


});
