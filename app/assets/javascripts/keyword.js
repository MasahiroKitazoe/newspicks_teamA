$(function() {
  $('#keyword-class-news').on('click', function() {
    $(this).css("color", "#4277FB");
    $(this).css("border-bottom", "2px solid #4277FB");
    $(this).css("font-weight", "bold");
    $('#keyword-class-comment').css("color", "#999");
    $('#keyword-class-comment').css("border-bottom", "2px solid #fff");
    $('#keyword-class-comment').css("font-weight", "normal");
    $('.keyword-wrapper__form__bottom__result__comments').css("display", "none");
    $('.keyword-wrapper__form__bottom__result__picks').css("display", "block");
  });
  $('#keyword-class-comment').on('click', function() {
    $(this).css("color", "#4277FB");
    $(this).css("border-bottom", "2px solid #4277FB");
    $(this).css("font-weight", "bold");
    $('#keyword-class-news').css("color", "#999");
    $('#keyword-class-news').css("border-bottom", "2px solid #fff");
    $('#keyword-class-news').css("font-weight", "normal");
    $('.keyword-wrapper__form__bottom__result__picks').css("display", "none");
    $('.keyword-wrapper__form__bottom__result__comments').css("display", "block");
  });

  function buildPick(pick) {
    var html = `<div class="keyword-wrapper__form__bottom__result__picks__news">
                    <div>
                        <div class="keyword-wrapper__form__bottom__result__picks__news__image" style="background-image: url(${pick.image})">
                          <div class="keyword-wrapper__form__bottom__result__picks__news__image__back">
                          </div>
                          <span class="keyword-wrapper__form__bottom__result__picks__news__image__picks-count">
                            <span class="keyword-wrapper__form__bottom__result__picks__news__image__picks-count__num">
                              ${pick.comments_count}
                            </span>
                            <span class="keyword-wrapper__form__bottom__result__picks__news__image__picks-count__text">
                              Picks
                            </span>
                          </span>
                        </div>
                        <div class="keyword-wrapper__form__bottom__result__picks__news__above">
                          <div class="keyword-wrapper__form__bottom__result__picks__news__above__title">
                            ${pick.title}
                          </div>
                          <div class="keyword-wrapper__form__bottom__result__picks__news__above__source">
                            ${pick.source} | ${pick.created_at}
                          </div>
                        </div>
                        <div class="keyword-wrapper__form__bottom__result__picks__news__body">
                          ${pick.body}
                        </div>
                    </div>
                  </div>`
    return html;
  }

  function buildNoPick(message) {
    var html = `<div class="keyword-wrapper__form__bottom__result__picks__news">
                  ${message}
                </div>`
    return html;
  }

  function buildComment(comment) {
    var insertPositon = '';
    if (comment.user_position) {
      insertPosition = `<span class="keyword-wrapper__form__bottom__result__comments__comment__user__info__more__position">
                                  ${comment.user_position}
                                </span>`
    }
    if (comment.liked == true) {
      var insertLikeBlock = `<div class="liked" data="${comment.like_id}">
                              <img class="search-result__comments__comment__like__icon thumb-up-r" src="/images/done-like-btn.png" alt="LikesImage">
                              <div class="search-result__comments__comment__like__likes-count count-r">
                                ${comment.like_count} Likes
                              </div>
                            </div>`;
    } else {
      var insertLikeBlock = `<div class="like">
                              <img class="search-result__comments__comment__like__icon thumb-up-g" src="/images/like-btn.png" alt="LikesImage">
                              <div class="search-result__comments__comment__like__likes-count count">
                                ${comment.like_count} Likes
                              </div>
                            </div>`;
    }
    var html = `<div class="keyword-wrapper__form__bottom__result__comments__comment">
                        <div class="keyword-wrapper__form__bottom__result__comments__comment__user">
                          <img src="${comment.user_image}" class="keyword-wrapper__form__bottom__result__comments__comment__user__image">
                          <div class="keyword-wrapper__form__bottom__result__comments__comment__user__info">
                            <div class="keyword-wrapper__form__bottom__result__comments__comment__user__info__name">
                              ${comment.user_last_name} ${comment.user_first_name}
                            </div>
                            <div class="keyword-wrapper__form__bottom__result__comments__comment__user__info__more">
                              ${insertPosition}
                              <span class="keyword-wrapper__form__bottom__result__comments__comment__user__info__more__date">
                                ${comment.created_at}
                              </span>
                            </div>
                          </div>
                        </div>
                        <div class="keyword-wrapper__form__bottom__result__comments__comment__body">
                          ${comment.comment}
                        </div>


                  <div class="search-result__comments__comment__like like-wrapper" id="like${comment.id}" data="${comment.id}">
                    ${insertLikeBlock}
                  </div>


                  <div class="keyword-wrapper__form__bottom__result__comments__comment__news">
                          <div class="keyword-wrapper__form__bottom__result__comments__comment__news__title">
                            ${comment.pick_title}
                          </div>
                          <div class="keyword-wrapper__form__bottom__result__comments__comment__news__info">
                            <span class="keyword-wrapper__form__bottom__result__comments__comment__news__info__source">
                              ${comment.pick_source}
                            </span> |
                            <span class="keyword-wrapper__form__bottom__result__comments__comment__news__info__date">
                              ${comment.pick_created_at}
                            </span>
                          </div>
                        </div>
                      </div>`
    return html;
  }

  function buildNoComment(message) {
    var html = `<div class="keyword-wrapper__form__bottom__result__comments__comment">
                  ${message}
                </div>`
    return html;
  }

  $('.fixed_keyword').on('click', function(e) {
    var keyword = $(e.currentTarget).data('keyword');
    $('.keyword-wrapper').css("display", "block");
    $('.keyword-wrapper__form__above__input').css("display", "none");
    $('.keyword-wrapper__form__above__keyword').text(keyword);
    $('.keyword-wrapper__form__above__keyword').css("display", "block");
    $('.keyword-wrapper__form__bottom__announce').css("display", "none");
    $('.keyword-wrapper__form__bottom__result').css("display", "block");
    $.ajax({
      type: 'GET',
      url: '/picks/lookup',
      data: { keyword },
      dataType: 'json'
    })
    .done(function(data) {
        var picks = data.picks
        var comments = data.comments
      $('.keyword-wrapper__form__bottom__result__picks').empty();
      var buildPicks = [];
      if (picks.length !== 0) {
        picks.forEach(function(pick) {
            buildPicks.push(buildPick(pick));
        });
        $('.keyword-wrapper__form__bottom__result__picks').append(buildPicks);
      } else {
        buildPicks.push(buildNoPick("該当する記事がありません"));
        $('.keyword-wrapper__form__bottom__result__picks').append(buildPicks);
      }
      $('.keyword-wrapper__form__bottom__result__comments').empty();
      var buildComments =[];
      if (comments.length !== 0) {
        comments.forEach(function(comment) {
          buildComments.push(buildComment(comment));
        });
        $('.keyword-wrapper__form__bottom__result__comments').append(buildComments);
      } else {
        buildComments.push(buildNoComment("該当するコメントがありません"));
        $('.keyword-wrapper__form__bottom__result__comments').append(buildComments);
      }
    })
    .fail(function() {
      alert('フィルタリングに失敗しました');
    })

    $('.keyword-wrapper__overlay').on('click', function(e) {
      if (e.target.className == "keyword-wrapper__overlay") {
        $('.keyword-wrapper').css("display", "none");
        $('.keyword-wrapper__form__above__keyword').css("display", "none");
        $('.keyword-wrapper__form__above__input').css("display", "block");
        $('.keyword-wrapper__form__bottom__result').css("display", "none");
        $('.keyword-wrapper__form__bottom__announce').css("display", "block");
      }
    });
  });

});
