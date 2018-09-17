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
    console.log('hello!');
    e.preventDefault();
    $('#signin').css("display", "block");

    // 背景をクリックするとモーダルを終了
    $('.signin__overlay').on('click', function(e) {
      if (e.target.className == "signin__overlay") {
        $('#signin').css("display", "none");
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

  // navbarのユーザ名をクリックした時
  $('#user-menu-trigger').on('click', function(e){
    e.preventDefault();
    $('.user_menu').css('display', 'block');
  });

  // 背景をクリックするとモーダルを終了
  $('.user_menu__overlay').on('click', function(e) {
    if (e.target.className == "user_menu__overlay") {
      $('#user_menu').css("display", "none");
    }
  });

  // themeのメニューをクリックした時
  $('#theme-menu-trigger').on('click', function(e){
    e.preventDefault();
    $('.theme_menu').css('display', 'block');
  });

  // 背景をクリックするとモーダルを終了
  $('.theme_menu__overlay').on('click', function(e) {
    console.log(e.target);
    if (e.target.className == "theme_menu__overlay") {
      $('#theme_menu').css("display", "none");
    }
  });

  // 旗印をクリックした時
  $('#notification-up-btn').on('click', function(e){
    e.preventDefault();
    $('#notifications').css('display', 'block');
  });

  // 背景をクリックするとモーダルを終了
  $('.notifications__overlay').on('click', function(e) {
    if (e.target.className == "notifications__overlay") {
      $('#notifications').css("display", "none");
    }
  });
   
  // keyword検索・登録
  $('#keyword-search').on('click', function(e) {
    e.preventDefault();
    $('.keyword-wrapper').css("display", "block");
    $('.keyword-wrapper__overlay').on('click', function(e) {
      if (e.target.className == "keyword-wrapper__overlay") {
        $('.keyword-wrapper').css("display", "none");
      }
    });
  });
});
