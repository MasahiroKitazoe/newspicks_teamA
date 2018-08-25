$(function() {
  // 「アカウント登録」クリック時、モーダルを表示
  $('#signup-btn').on('click', function(e) {
    e.preventDefault();
    $('#signup').css("display", "block");

    // 背景をクリックするとモーダルを終了
    $('.signup__overlay').on('click', function(e) {
      console.log(e.target);
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
      console.log(e.target);
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
      console.log(e.target);
      if (e.target.className == "newpick__overlay") {
        $('#newpick').css("display", "none");
      }
  });

  });
});
