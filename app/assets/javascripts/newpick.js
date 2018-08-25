$(function() {

  $('#newpick-box').on('keyup', function(e) {

    // 失敗時メッセージの削除
    if ($('#notfound')) {$('#notfound').remove()}

    // スクレイピングするURLを変数に格納
    var input = $('#newpick-box').val();

    // ajax通信
    if (input.length > 5) {
      $.ajax({
      type: "GET",
      url: '/picks/search',
      data: { url: input },
      dataType: 'json',
      })
      .done(function(data){
        $('.page-thumbnail').css('background-image', `url(${data.image})`);
        $('.pick-title span').text(data.title);
        $('.pick-body span').text(data.body);
        $('.pick-demand').css('display', 'none');
        $('.pick-site').css('display', 'block');
      })
      .fail(function(){
        html = `<div id="notfound" style="color: red; margin-top: 30px;">指定された URL のページが見つかりません</div>`
        $('.pick-window').append(html)
      })
    }
  })
});
