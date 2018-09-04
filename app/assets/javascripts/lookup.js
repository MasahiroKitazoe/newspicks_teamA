$(function() {
  // トップクリック時に@picksを表示
  $('#select-picks').on('click', function() {
    $('#searched-picks').css("display", "block");
    $('#searched-comments').css("display", "none");
    $('#searched-users').css("display", "none");
    $('#select-picks').css("border-bottom", "2px solid #221f20");
    $('#select-comments').css("border-bottom", "2px solid #fff");
    $('#select-users').css("border-bottom", "2px solid #fff");
    $('#comment-sort').css("display", "none");
    $('#pick-sort').css("display", "block");
  });
  // コメントクリック時に@commentsを表示
  $('#select-comments').on('click', function() {
    $('#searched-picks').css("display", "none");
    $('#searched-users').css("display", "none");
    $('#searched-comments').css("display", "block");
    $('#select-picks').css("border-bottom", "2px solid #fff");
    $('#select-users').css("border-bottom", "2px solid #fff");
    $('#select-comments').css("border-bottom", "2px solid #221f20");
    $('#pick-sort').css("display", "none");
    $('#comment-sort').css("display", "block");
  });
  // トップユーザー時に@usersを表示
  $('#select-users').on('click', function() {
    $('#searched-users').css("display", "block");
    $('#searched-picks').css("display", "none");
    $('#searched-comments').css("display", "none");
    $('#select-picks').css("border-bottom", "2px solid #fff");
    $('#select-comments').css("border-bottom", "2px solid #fff");
    $('#select-users').css("border-bottom", "2px solid #221f20");
    $('#pick-sort').css("display", "none");
    $('#comment-sort').css("display", "none");
  });

  // ソート/フィルター
  // Pick
  // 「PICK数」をクリックしたらメニューを表示
  $('.search-result__pick-sort__pick-count').on('click', function() {
    $('.search-result__pick-sort__pick-count > .search-result__pick-sort__select').text('');
    $(this).css("background-color", "#fff");
    $('.search-result__pick-sort__pick-count__filter').css("display", "block");
    $(this).css("border", "1px solid #aaa");
    $('.search-result').on('click', function(e) {
      if (e.target.className != "search-result__pick-sort__pick-count" && e.target.className != "search-result__pick-sort__pick-count__filter" && e.target.className != "search-result__pick-sort__select") {
        $('.search-result__pick-sort__pick-count > .search-result__pick-sort__select').text('指定なし');
        $('.search-result__pick-sort__pick-count').css("background-color", "#ccc");
        $('.search-result__pick-sort__pick-count__filter').css("display", "none");
        $('.search-result__pick-sort__pick-count').css("border", "0");
      }
    });
  });

  // 「期間」をクリックしたらメニューを表示

  // Comment
});
