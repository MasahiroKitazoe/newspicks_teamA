$(function() {
  // トップクリック時に@picksを表示
  $('#select-picks').on('click', function() {
    $('#searched-picks').css("display", "block");
    $('#searched-comments').css("display", "none");
    $('#searched-users').css("display", "none");
    $('#select-picks').css("border-bottom", "2px solid #221f20");
    $('#select-comments').css("border-bottom", "2px solid #fff");
    $('#select-users').css("border-bottom", "2px solid #fff");
  });
  // コメントクリック時に@commentsを表示
  $('#select-comments').on('click', function() {
    $('#searched-picks').css("display", "none");
    $('#searched-users').css("display", "none");
    $('#searched-comments').css("display", "block");
    $('#select-picks').css("border-bottom", "2px solid #fff");
    $('#select-users').css("border-bottom", "2px solid #fff");
    $('#select-comments').css("border-bottom", "2px solid #221f20");
  });
  // トップユーザー時に@usersを表示
  $('#select-users').on('click', function() {
    $('#searched-users').css("display", "block");
    $('#searched-picks').css("display", "none");
    $('#searched-comments').css("display", "none");
    $('#select-picks').css("border-bottom", "2px solid #fff");
    $('#select-comments').css("border-bottom", "2px solid #fff");
    $('#select-users').css("border-bottom", "2px solid #221f20");
  });
});
