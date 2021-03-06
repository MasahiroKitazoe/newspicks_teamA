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
    var html = `<div class="side-bar__keyword-news__news" data-id=${comment.id}>
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
                  <a href="/picks/${comment.pick_id}">
                    <p class="side-bar__keyword-news__news__text">
                      ${comment.pick_title}
                    </p>
                  </a>
                </div>`
    return html;
  }
  if ($('#my-news').length) {
      var url = $('#my-news').attr('href');
      $.ajax({
        type: 'GET',
        url: url,
        dataType: 'json'
      })
      .done(function(data) {
        var myNews = data.my_comments
        if (myNews.length !== 0) {
          var comments = [];
          myNews.forEach(function(comment) {
            comments.push(buildHTML(comment));
          })
          $('.side-bar__keyword-news').append(comments);
        }
      })
      .fail(function() {
        alert('ページを再読み込みしてください');
        // location.reload();
      });

    setInterval(function() {
      var comment_id = $('.side-bar__keyword-news__news:first').data('id');
      $.ajax({
      type: 'GET',
      url: url,
      data: { comment_id },
      dataType: 'json'
      })
      .done(function(data) {
        var latestNews = data.latest_comments
        if (latestNews.length !== 0) {
          var comments = [];
          latestNews.forEach(function(comment) {
            comments.push(buildHTML(comment));
          })
          $('.side-bar__keyword-news').prepend(comments);
        }
      })
      .fail(function(data) {
        alert('ページを再読み込みしてください');
        // location.reload();
      })
    }, 5000);
  }
});
