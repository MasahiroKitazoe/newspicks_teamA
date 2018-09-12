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
    .done(function(picks) {
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
