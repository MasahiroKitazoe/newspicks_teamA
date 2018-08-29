$(function() {
  // 「アカウント登録」クリック時、モーダルを表示
  $('#signup-btn').on('click', function(e) {
    e.preventDefault();
    $('#signup').css("display", "block");

    // 背景をクリックするとモーダルを終了
    $('.signup__overlay').on('click', function(e) {
      if (e.target.className == "signup__overlay") {
        $('#signup').css("display", "none");
      }
    });
  });


  // 「ログイン」クリック時
  $('#signin-btn').on('click', function(e) {
    e.preventDefault();
    $('#signin').css("display", "block");

    // 背景をクリックするとモーダルを終了
    $('.signin__overlay').on('click', function(e) {
      if (e.target.className == "signin__overlay") {
        $('#signin').css("display", "none");
      }
    });
  });

    // 「Pick」クリック時
  $('#new-pick-btn').on('click', function(e) {
    e.preventDefault();
    $('#newpick').css("display", "block");

    // 背景をクリックするとモーダルを終了
    $('.newpick__overlay').on('click', function(e) {
      if (e.target.className == "newpick__overlay") {
        $('#newpick').css("display", "none");
      }
    });
  });

  // 「ログインはこちら」クリック時にログインモーダル表示
  $('#signin-link').on('click', function(e) {
    e.preventDefault();
    $('#signup').css("display", "none");
    $('#signin').css("display", "block");

    // 背景をクリックするとモーダルを終了
    $('.signin__overlay').on('click', function(e) {
      if (e.target.className == "signin__overlay") {
        $('#signin').css("display", "none");
      }
    });
  })



  // 「新規登録はこちら」クリック時に新規登録モーダル表示
  $('#signup-link').on('click', function(e) {
    e.preventDefault();
    $('#signin').css("display", "none");
    $('#signup').css("display", "block");

    // 背景をクリックするとモーダルを終了
    $('.signup__overlay').on('click', function(e) {
      if (e.target.className == "signup__overlay") {
        $('#signup').css("display", "none");
      }
    });
  })


});
