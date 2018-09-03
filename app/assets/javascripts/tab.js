$(function() {

  function switchContent(item){
    var target_id = `#tab-selected-${item}`
    console.log(target_id);

    // 現在の表示コンテンツを消す
    $('.tab-content').css('display', 'none');

    // コンテンツの表示
    $(target_id).css('display', 'block');
  };

  // マウスが来たらselect状態にし、離れたら解除する
  $('.tab-item').mouseover(function(){
    if ($(this).attr('id') != 'user-follow-box') {
      $(this).removeClass();
      $(this).addClass("tab-item selected");
    }
  })
  .mouseout(function(){
    $(this).removeClass();
    $(this).addClass("tab-item");
  });

  $('.tab-item').on('click', function(e){

    // mouseover用のクラス名を初期化
    $(this).siblings().removeClass('selected');

    // 表示コンテンツの特定
    var item = $(this).attr('data');

    // タブのCSS変更
    $(this).siblings().attr('id', '');
    if ($(this).attr('id') !== 'tab-selected') {
      $(this).attr('id', 'tab-selected');
      switchContent(item);
    }
  })
});
