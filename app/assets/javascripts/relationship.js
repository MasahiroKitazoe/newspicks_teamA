$(function() {

  // フォローする関数
  $('.create-relation').on('click', function(e){
    e.preventDefault();
    e.stopPropagation();

    // フォローするユーザーのidを取得
    var followed_id = $(this).attr('data')

    // フォローボタン付きリンクをappendする親要素のidを取得
    var parent_id = $(this).parent().attr('id')
    var target_id = `#${parent_id}`

    $.ajax({
      type: "POST",
      url: '/relationships',
      data: { followed_id: followed_id },
      dataType: 'json',
      })
      .done(function(data){
        var html = `<a class="destroy-relation" data=${followed_id} rel="nofollow" data-method="delete" href="/relationships/${data.id}">
                      <img src="/images/following-btn.png" class="relation-btn"></a>`
        $(target_id).empty();
        $(target_id).append(html);
      })
      .fail(function(){
        alert('フォローに失敗しました');
      })
  });

  // フォロー解除の関数
  $('.destroy-relation').on('click', function(e){
    e.preventDefault();
    e.stopPropagation();

    // フォローするユーザーのidを取得
    var followed_id = $(this).attr('data')

    // フォローボタン付きリンクをappendする親要素のidを取得
    var parent_id = $(this).parent().attr('id')
    var target_id = `#${parent_id}`

    $.ajax({
      type: "DELETE",
      url: `/relationships/${followed_id}`,
      data: { followed_id: followed_id },
      dataType: 'json',
      })
      .done(function(data){
        var html = `<a class="create-relation" data=${followed_id} rel="nofollow" data-method="post" href="/relationships">
                      <img src="/images/follow-btn.png" class="relation-btn"></a>`
        $(target_id).empty();
        $(target_id).append(html);
      })
      .fail(function(){
        alert('フォロー解除に失敗しました');
      })
  });
});
