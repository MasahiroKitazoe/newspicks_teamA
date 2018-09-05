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
  $('.search-result__pick-sort__pick-count').on('click', function() {
    $('.search-result__pick-sort__pick-count > .search-result__pick-sort__select').css("display", "none");
    $(this).css("background-color", "#fff");
    $('.search-result__pick-sort__pick-count__filter').css("display", "block");
    $(this).css("border", "1px solid #aaa");
    $('.search-result').on('click', function(e) {
      if (e.target.className != "search-result__pick-sort__pick-count" && e.target.className != "search-result__pick-sort__pick-count__filter" && e.target.className != "search-result__pick-sort__select") {
        $('.search-result__pick-sort__pick-count > .search-result__pick-sort__select').css("display", "inline-block");
        $('.search-result__pick-sort__pick-count').css("background-color", "#eee");
        $('.search-result__pick-sort__pick-count__filter').css("display", "none");
        $('.search-result__pick-sort__pick-count').css("border", "0");
      }
    });
  });

  $('.search-result__pick-sort__period').on('click', function() {
    $('.search-result__pick-sort__period > .search-result__pick-sort__select').css("display", "none");
    $(this).css("background-color", "#fff");
    $('.search-result__pick-sort__period__filter').css("display", "block");
    $(this).css("border", "1px solid #aaa");
    $('.search-result').on('click', function(e) {
      if (e.target.className != "search-result__pick-sort__period" && e.target.className != "search-result__pick-sort__period__filter" && e.target.className != "search-result__pick-sort__select") {
        $('.search-result__pick-sort__period > .search-result__pick-sort__select').css("display", "inline-block");
        $('.search-result__pick-sort__period').css("background-color", "#eee");
        $('.search-result__pick-sort__period__filter').css("display", "none");
        $('.search-result__pick-sort__period').css("border", "0");
      }
    });
  });

  // Comment
  $('.search-result__comment-sort__like-count').on('click', function() {
    $('.search-result__comment-sort__like-count > .search-result__comment-sort__select').css("display", "none");
    $(this).css("background-color", "#fff");
    $('.search-result__comment-sort__like-count__filter').css("display", "block");
    $(this).css("border", "1px solid #aaa");
    $('.search-result').on('click', function(e) {
      if (e.target.className != "search-result__comment-sort__like-count" && e.target.className != "search-result__comment-sort__like-count__filter" && e.target.className != "search-result__comment-sort__select") {
        $('.search-result__comment-sort__like-count > .search-result__comment-sort__select').css("display", "inline-block");
        $('.search-result__comment-sort__like-count').css("background-color", "#eee");
        $('.search-result__comment-sort__like-count__filter').css("display", "none");
        $('.search-result__comment-sort__like-count').css("border", "0");
      }
    });
  });

  $('.search-result__comment-sort__period').on('click', function() {
    $('.search-result__comment-sort__period > .search-result__comment-sort__select').css("display", "none");
    $(this).css("background-color", "#fff");
    $('.search-result__comment-sort__period__filter').css("display", "block");
    $(this).css("border", "1px solid #aaa");
    $('.search-result').on('click', function(e) {
      if (e.target.className != "search-result__comment-sort__period" && e.target.className != "search-result__comment-sort__period__filter" && e.target.className != "search-result__comment-sort__select") {
        $('.search-result__comment-sort__period > .search-result__comment-sort__select').css("display", "inline-block");
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

  // フィルター後のcommentをappendする処理
  function appendComment(comment) {
    var insertPositon = '';
    if (comment.user_positon) {
      insertPositon = `<span class="search-result__comments__comment__user__info__more__position">
                          ${comment.user_position}
                        </span>`
    }
    var html = `<div class="search-result__comments__comment">
                  <div class="search-result__comments__comment__user">
                    <img src="${comment.user_image}", class="search-result__comments__comment__user__image">
                    <div class="search-result__comments__comment__user__info">
                      <div class="search-result__comments__comment__user__info__name">
                        ${comment.user_last_name} ${comment.user_first_name}
                      </div>
                      <div class="search-result__comments__comment__user__info__more">
                        ${insertPositon}
                        <span class="search-result__comments__comment__user__info__more__date">
                          ${comment.created_at}
                        </span>
                      </div>
                    </div>
                  </div>
                  <div class="search-result__comments__comment__body">
                    ${comment.comment}
                  </div>
                  <div class="search-result__comments__comment__like">
                    <img class="search-result__comments__comment__like__icon" src="/images/like-btn.png" alt="LikesImage">
                    <div class="search-result__comments__comment__like__likes-count">
                      ${comment.like_count} Likes
                    </div>
                  </div>
                  <div class="search-result__comments__comment__news">
                    <div class="search-result__comments__comment__news__title">
                      ${comment.pick_title}
                    </div>
                    <div class="search-result__comments__comment__news__info">
                      <span class="search-result__comments__comment__news__info__source">
                        ${comment.pick_source}
                      </span> |
                      <span class="search-result__comments__comment__news__info__date">
                        ${comment.pick_created_at}
                      </span>
                    </div>
                  </div>
                </div>`
    $('#searched-comments').append(html);
  }

  // フィルター後commentが存在しない場合の処理
  function appendNoComment(message) {
    var html = `<div class="search-result__comments__comment">
                  ${message}
                </div>`
    $('#searched-comments').append(html);
  }

  // Ajax処理
  $('.pick-comments__filter').on('click', function(e) {
    e.preventDefault();
    var pick_num = $(e.currentTarget).data('pick-num');
    var keyword = $(e.currentTarget).data('keyword');
    var pick_time = $('.search-result__pick-sort__period > .search-result__pick-sort__select').data('pickTime');
    $.ajax({
      type: 'GET',
      url: '/picks/lookup',
      // pick_timeを送って再建策
      data: { pick_num,
              keyword,
              pick_time },
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
      $('.search-result__pick-sort__pick-count > .search-result__pick-sort__select').text($(e.currentTarget).text());
      // ここにデータをセットして期間フィルタ時にリクエストと一緒に送信する
      $('.search-result__pick-sort__pick-count > .search-result__pick-sort__select').attr('data-pick-num', pick_num);
      $('.search-result__pick-sort__pick-count > .search-result__pick-sort__select').css("display", "inline-block");
      $('.search-result__pick-sort__pick-count').css("background-color", "#eee");
      $('.search-result__pick-sort__pick-count__filter').css("display", "none");
      $('.search-result__pick-sort__pick-count').css("border", "0");
    })
    .fail(function() {
      alert('フィルタリングに失敗しました');
    })
  });

  $('.pick-period__filter').on('click', function(e) {
    e.preventDefault();
    var pick_time = $(e.currentTarget).data('pick-time');
    var keyword = $(e.currentTarget).data('keyword');
    var pick_num = $('.search-result__pick-sort__pick-count > .search-result__pick-sort__select').data('pickNum');
    $.ajax({
      type: 'GET',
      url: '/picks/lookup',
      // pick_numを送って再建策
      data: { pick_time,
              keyword,
              pick_num },
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
      $('.search-result__pick-sort__period > .search-result__pick-sort__select').text($(e.currentTarget).text());
      $('.search-result__pick-sort__period > .search-result__pick-sort__select').attr('data-pick-time', pick_time);
      $('.search-result__pick-sort__period > .search-result__pick-sort__select').css("display", "inline-block");
      $('.search-result__pick-sort__period').css("background-color", "#eee");
      $('.search-result__pick-sort__period__filter').css("display", "none");
      $('.search-result__pick-sort__period').css("border", "0");
    })
    .fail(function() {
      alert('フィルタリングに失敗しました');
    })
  })

  // Commentsフィルター
  $('.comment-likes__filter').on('click', function(e) {
    e.preventDefault();
    var comment_num = $(e.currentTarget).data('comment-num');
    var keyword = $(e.currentTarget).data('keyword');
    // console.log(num); -> num == {num: 0}
    $.ajax({
      type: 'GET',
      url: '/picks/lookup',
      data: { comment_num,
              keyword },
      dataType: 'json'
    })
    .done(function(comments) {
      // 既に表示しているpicksを空に
      $('#searched-comments').empty();
      // 取得したpicksを一個ずつappend
      if (comments.length !== 0) {
        comments.forEach(function(comment) {
          appendComment(comment);
        });
      } else {
        appendNoComment("該当するコメントがありません")
      }
      $('.search-result__comment-sort__like-count > .search-result__comment-sort__select').text($(e.currentTarget).text());
      $('.search-result__comment-sort__like-count > .search-result__comment-sort__select').attr('data-comment-num', comment_num);
      $('.search-result__comment-sort__like-count > .search-result__comment-sort__select').css("display", "inline-block");
      $('.search-result__comment-sort__like-count').css("background-color", "#eee");
      $('.search-result__comment-sort__like-count__filter').css("display", "none");
      $('.search-result__comment-sort__like-count').css("border", "0");
    })
    .fail(function() {
      alert('フィルタリングに失敗しました');
    })
  });

  $('.comment-period__filter').on('click', function(e) {
    e.preventDefault();
    var comment_time = $(e.currentTarget).data('comment-time');
    var keyword = $(e.currentTarget).data('keyword');
    var comment_num = $('.search-result__comment-sort__like-count > .search-result__comment-sort__select').data('commentNum');
    $.ajax({
      type: 'GET',
      url: '/picks/lookup',
      data: { comment_time,
              keyword,
              comment_num },
      dataType: 'json'
    })
    .done(function(comments) {
      // 既に表示しているpicksを空に
      $('#searched-comments').empty();
      // 取得したpicksを一個ずつappend
      if (comments.length !== 0) {
        comments.forEach(function(comment) {
          appendComment(comment);
        });
      } else {
        appendNoComment("該当するコメントがありません")
      }
      $('.search-result__comment-sort__period > .search-result__comment-sort__select').text($(e.currentTarget).text());
      $('.search-result__comment-sort__period > .search-result__comment-sort__select').css("display", "inline-block");
      $('.search-result__comment-sort__period').css("background-color", "#eee");
      $('.search-result__comment-sort__period__filter').css("display", "none");
      $('.search-result__comment-sort__period').css("border", "0");
    })
    .fail(function() {
      alert('フィルタリングに失敗しました');
    })
  });
});
