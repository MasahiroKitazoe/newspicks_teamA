$(function(){
  function buildHTML(comment){
    var html = `
<div class="comment-container">
  <div class="comment-row with-border" data-user="267866" data-news="3250274" follow-user="false" data-comment-version="1" mute-disable="false">
    <div class="user-space">
      <a onclick="NP.showUserSummary(event)" data-user="267866" href="/user/267866?ref=news-summary_3250274">
        <img class="user-cover" src="https://pbs.twimg.com/profile_images/1000993501415329792/EVcLnIF-_400x400.jpg">
      </a>
      <div class="user-profile">
        <a onclick="NP.showUserSummary(event)" data-user="267866" href="/user/267866?ref=news-summary_3250274">
          <div class="name-wrapper">
            <div class="name">
              ${ comment.user_first_name }
            </div>
          </div>
        </a>
        <div class="job">
          ${comment.user_company}
        </div>
        <div class="picktime">
          6時間前
        </div>
        <div class="drop-down-button">
          <div class="drop-down-button-1">⋮</div>
        </div>
      </div>
    </div>
    <div class="comment-wrapper">
      <div class="comment">
        ${ comment.comment }
      </div>
      <div class="like-panel">
        <div class="like-wrapper">
          <div class="like" onclick="NP.like(this)" data-user="267866" data-liked="false" data-news="3250274">
            <div class="count">
              14
            </div>
            <div class="like-label">Likes
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="embedded-pick-editor" style="display:none">
    </div>
  </div>
</div>`;
  return html;
  }
  $("#new_comment").on("submit", function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var href = $(this).attr('action');

    $.ajax({
      type: 'POST',
      url: href,
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false,
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.followings').append(html);
      $('form')[0].reset();
    })
    .fail(function(){
      alert('コメントを送信できませんでした。');
    })
  })
})
