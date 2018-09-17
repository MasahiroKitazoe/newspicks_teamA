$(function() {
  function buildHTML(comment) {
    if (comment.keyword) {
      var insertKeyword = `<p class="side-bar__keyword-news__news__keyword">
                              <span class="side-bar__keyword-news__news__keyword__em">
                                ${comment.keyword}
                              </span>の記事
                            </p>`
    } else {
      var insertKeyword = `<p class="side-bar__keyword-news__news__keyword">
                            </p>`
    }
    var html = `<div class="side-bar__keyword-news__news">
                  ${insertKeyword}
                  <div class="side-bar__keyword-news__news__user">
                    <img class="side-bar__keyword-news__news__user__image" src="${comment.user_image}">
                    <div class="side-bar__keyword-news__news__user__info">
                      <a href="#" class="side-bar__keyword-news__news__user__name">
                        ${comment.user_last_name} ${comment.user_first_name}
                      </a>
                      <p class="side-bar__keyword-news__news__user__time">
                        ${comment.created_at}
                      </p>
                    </div>
                  </div>
                  <p class="side-bar__keyword-news__news__comment">
                    ${comment.comment}
                  </p>
                  <p class="side-bar__keyword-news__news__text">
                    ${comment.pick_title}
                  </p>
                </div>`
    return html;
  }

  var url = $('#my-news').attr('href');
  $.ajax({
      type: 'GET',
      url: url,
      dataType: 'json'
    })
    .done(function(data) {
      if (data.length !== 0) {
        var comments = [];
        data.forEach(function(comment) {
          comments.push(buildHTML(comment));
        })
        $('.side-bar__keyword-news').append(comments);
      }
    })
    .fail(function() {
      alert('マイニュースの取得に失敗しました');
    })
});
