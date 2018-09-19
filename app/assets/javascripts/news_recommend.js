$(function() {
  function buildHTML(pick) {
    var html = `<div class="news-recommend-info">
                  <a href="picks/${pick.id}">
                    <div class="news-recommend-element-title">
                      ${pick.short_title}
                    </div>
                  </a>
                </div>`
    return html
  }

  function buildINFO() {
    var html = `<div class="news-recommend-title">おすすめニュース</div>`
    return html
  }

  $('#news-recommendation-btn').on('click', function(e){
    user_id = $(this).attr('data')
    $.ajax('https://gentle-tundra-41702.herokuapp.com/api/' + user_id + '/')
    .done(function(data) {
      for (var i = 1; i <= 5; i++) {
        var pick_id = data[i][0]
        $.ajax ({
          type: 'GET',
          url: `/picks/${pick_id}`,
          dataType: 'json'
        })
        .done(function(data){
          html = buildHTML(data)
          $('.side-bar__keyword-news').prepend(html)
        })
        .fail(function(){
          alert('一部失敗しました')
        });
      }
      e.preventDefault();
    })
    .fail(function() {
      alert('全部失敗しました')
    })
    .always(function(){
      setTimeout(function(){
        html = buildINFO()
        $('.side-bar__keyword-news').prepend(html)
      }, 500);
    });
  });
});


