$(function() {

  function buildLikeView(data){
    html = `<div class="like">
              <img class="thumb-up-g" src="/images/like-btn.png" style="width: 10px;, height: 14px;">
              <div class="count">
                ${data.like_count}
              </div>
              <div class="like-label">Likes
              </div>
            </div>`
    return html
  }

  function buildUnlikeView(data){
    html = `<div class="liked" data="${data.id}">
              <img class="thumb-up-r" src="/images/done-like-btn.png" style="width: 10px;, height: 14px;">
              <div class="count-r">
                ${data.like_count}
              </div>
              <div class="like-label-r">Likes
              </div>
            </div>`
    return html
  }

  function getCommentId(element){
    return element.attr('data');
  }

  $('.search-result').on('click', '.liked', function(e){
    e.preventDefault();
    var trigger_id = "#" + $(this).parent().attr('id')
    var unlike_ele = $(this)
    var comment_id = getCommentId($(this).parent());
    var like_id = $(this).attr('data')

    // Likeを取り消す
    $.ajax({
      type: "DELETE",
      url: `/likes/${like_id}`,
      data: { comment_id: comment_id, id: like_id },
      dataType: 'json',
    })
    .done(function(data){
      // 既存のいいね済みビューを削除
      unlike_ele.remove();

      // appendする要素の生成
      html = buildLikeView(data);

      // 未Likeビューをappend
      $(trigger_id).append(html);
    })
    .fail(function(){
      alert('失敗しました')
    })
  });

  $('.like-wrapper').on('click', '.like', function(e){
    e.preventDefault();
    var trigger_id = "#" + $(this).parent().attr('id')
    var like_ele = $(this)
    var comment_id = getCommentId($(trigger_id));

    // Likeする
    $.ajax({
      type: "POST",
      url: '/likes',
      data: { comment_id: comment_id },
      dataType: 'json',
    })
    .done(function(data){
      // 既存のいいね済みビューを削除
      like_ele.remove();

      // appendする要素の生成
      html = buildUnlikeView(data);

      // 未Likeビューをappend
      $(trigger_id).append(html);
    })
    .fail(function(){
      alert('失敗しました')
    })
  });
});
