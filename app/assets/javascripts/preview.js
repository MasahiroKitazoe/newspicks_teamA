$(function() {
  //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
  $('#edit-form').on('change', 'input[type="file"]', function(e) {
    var file = e.target.files[0],
        reader = new FileReader();
        $preview = $('#preview')

    // 画像ファイル以外は何もしない
    if(file.type.indexOf("image") < 0) {
      return false;
    }

    // ファイル読み込みが完了した際のイベント登録
    reader.onload = (function(file) {
      return function(e) {
        // src属性を読み込んだ画像のパスに
        $preview.attr({
                  src: e.target.result
                });
      };
    })(file);

    reader.readAsDataURL(file);
  });
});
