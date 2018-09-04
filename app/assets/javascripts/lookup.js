$(function() {
  // トップクリック時に@picksを表示
  $('#select-picks').on('click', function() {
    $('#searched-picks').css("display", "block");
    $('#searched-comments').css("display", "none");
    $('#searched-users').css("display", "none");
    $('#select-picks').css("border-bottom", "2px solid #221f20");
    $('#select-comments').css("border-bottom", "2px solid #fff");
    $('#select-users').css("border-bottom", "2px solid #fff");
    $('#select-picks').css("color", "#221f20");
    $('#select-comments').css("color", "rgb(153, 153, 153)");
    $('#select-users').css("color", "rgb(153, 153, 153)");
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
    $('#select-comments').css("color", "#221f20");
    $('#select-picks').css("color", "rgb(153, 153, 153)");
    $('#select-users').css("color", "rgb(153, 153, 153)");
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
    $('#select-users').css("color", "#221f20");
    $('#select-comments').css("color", "rgb(153, 153, 153)");
    $('#select-picks').css("color", "rgb(153, 153, 153)");
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
    // フィルターメニューを閉じる
    $('.search-result').on('click', function(e) {
      if (e.target.className != "search-result__pick-sort__pick-count" && e.target.className != "search-result__pick-sort__pick-count__filter" && e.target.className != "search-result__pick-sort__select") {
        $('.search-result__pick-sort__pick-count > .search-result__pick-sort__select').text('指定なし');
        $('.search-result__pick-sort__pick-count').css("background-color", "#eee");
        $('.search-result__pick-sort__pick-count__filter').css("display", "none");
        $('.search-result__pick-sort__pick-count').css("border", "0");
      }
    });
  });

  // 「期間」をクリックしたらメニューを表示
  $('.search-result__pick-sort__period').on('click', function() {
    $('.search-result__pick-sort__period > .search-result__pick-sort__select').text('');
    $(this).css("background-color", "#fff");
    $('.search-result__pick-sort__period__filter').css("display", "block");
    $(this).css("border", "1px solid #aaa");
    // フィルターメニューを閉じる
    $('.search-result').on('click', function(e) {
      if (e.target.className != "search-result__pick-sort__period" && e.target.className != "search-result__pick-sort__period__filter" && e.target.className != "search-result__pick-sort__select") {
        $('.search-result__pick-sort__period > .search-result__pick-sort__select').text('指定なし');
        $('.search-result__pick-sort__period').css("background-color", "#eee");
        $('.search-result__pick-sort__period__filter').css("display", "none");
        $('.search-result__pick-sort__period').css("border", "0");
      }
    });
  });

  // Comment
  // 「LIKE数」をクリックしたらメニューを表示
  $('.search-result__comment-sort__like-count').on('click', function() {
    $('.search-result__comment-sort__like-count > .search-result__comment-sort__select').text('');
    $(this).css("background-color", "#fff");
    $('.search-result__comment-sort__like-count__filter').css("display", "block");
    $(this).css("border", "1px solid #aaa");
    // フィルターメニューを閉じる
    $('.search-result').on('click', function(e) {
      if (e.target.className != "search-result__comment-sort__like-count" && e.target.className != "search-result__comment-sort__like-count__filter" && e.target.className != "search-result__comment-sort__select") {
        $('.search-result__comment-sort__like-count > .search-result__comment-sort__select').text('指定なし');
        $('.search-result__comment-sort__like-count').css("background-color", "#eee");
        $('.search-result__comment-sort__like-count__filter').css("display", "none");
        $('.search-result__comment-sort__like-count').css("border", "0");
      }
    });
  });

  // 「期間」をクリックしたらメニューを表示
  $('.search-result__comment-sort__period').on('click', function() {
    $('.search-result__comment-sort__period > .search-result__comment-sort__select').text('');
    $(this).css("background-color", "#fff");
    $('.search-result__comment-sort__period__filter').css("display", "block");
    $(this).css("border", "1px solid #aaa");
    // フィルターメニューを閉じる
    $('.search-result').on('click', function(e) {
      if (e.target.className != "search-result__comment-sort__period" && e.target.className != "search-result__comment-sort__period__filter" && e.target.className != "search-result__comment-sort__select") {
        $('.search-result__comment-sort__period > .search-result__comment-sort__select').text('指定なし');
        $('.search-result__comment-sort__period').css("background-color", "#eee");
        $('.search-result__comment-sort__period__filter').css("display", "none");
        $('.search-result__comment-sort__period').css("border", "0");
      }
    });
  });

  // フィルター後のpickをappendする処理
  function appendPick(pick) {
    var html = `<div class="search-result__picks__news">
                  <div>
                      <div class="search-result__picks__news__image" style="background-image: url(${pick.image})">
                        <div class="search-result__picks__news__image__back">
                        </div>
                        <span class="search-result__picks__news__image__picks-count">
                          <span class="search-result__picks__news__image__picks-count__num">
                            ${pick.comments_count}
                          </span>
                          <span class="search-result__picks__news__image__picks-count__text">
                            Picks
                          </span>
                        </span>
                      </div>
                      <div class="search-result__picks__news__above">
                        <div class="search-result__picks__news__above__title">
                          ${pick.title}
                        </div>
                        <div class="search-result__picks__news__above__source">
                          ${pick.source} | ${pick.created_at}
                        </div>
                      </div>
                      <div class="search-result__picks__news__body">
                        ${pick.body}
                      </div>
                  </div>
                </div>`
    $('#searched-picks').append(html);
  }

  // フィルター後pickが存在しない場合の処理
  function appendNoPick(message) {
    var html = `<div class="search-result__picks__news">
                  ${message}
                </div>`
    $('#searched-picks').append(html);
  }

  // Ajax処理
  // Picksフィルター
  // コメント数フィルター
  $('.pick-comments__filter').on('click', function(e) {
    e.preventDefault();
    var num = $(e.currentTarget).data('num');
    var keyword = $(e.currentTarget).data('keyword');
    // console.log(num); -> num == {num: 0}
    $.ajax({
      type: 'GET',
      url: '/picks/lookup',
      data: { num,
              keyword },
      dataType: 'json'
    })
    .done(function(picks) {
      // 既に表示しているpicksを空に
      $('#searched-picks').empty();
      // 取得したpicksを一個ずつappend
      if (picks.length !== 0) {
        picks.forEach(function(pick) {
          appendPick(pick);
        });
      } else {
        appendNoPick("該当する記事がありません")
      }
    })
    .fail(function() {
      alert('フィルタリングに失敗しました');
    })
  });

  // 期間フィルター
  $('.pick-period__filter').on('click', function(e) {
    e.preventDefault();
    var time = $(e.currentTarget).data('time');
    var keyword = $(e.currentTarget).data('keyword');
    $.ajax({
      type: 'GET',
      url: '/picks/lookup',
      data: { time,
              keyword },
      dataType: 'json'
    })
    .done(function(picks) {
      // 既に表示しているpicksを空に
      $('#searched-picks').empty();
      // 取得したpicksを一個ずつappend
      if (picks.length !== 0) {
        picks.forEach(function(pick) {
          appendPick(pick);
        });
      } else {
        appendNoPick("該当する記事がありません")
      }
    })
    .fail(function() {
      alert('フィルタリングに失敗しました');
    })
  })
});
