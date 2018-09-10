$(function() {
  $('#keyword-class-news').on('click', function() {
    $(this).css("color", "#4277FB");
    $(this).css("border-bottom", "2px solid #4277FB");
    $('#keyword-class-comment').css("color", "#999");
    $('#keyword-class-comment').css("border-bottom", "2px solid #fff");
    $('.keyword-wrapper__form__bottom__result__comments').css("display", "none");
    $('.keyword-wrapper__form__bottom__result__picks').css("display", "block");
  });
  $('#keyword-class-comment').on('click', function() {
    $(this).css("color", "#4277FB");
    $(this).css("border-bottom", "2px solid #4277FB");
    $('#keyword-class-news').css("color", "#999");
    $('#keyword-class-news').css("border-bottom", "2px solid #fff");
    $('.keyword-wrapper__form__bottom__result__picks').css("display", "none");
    $('.keyword-wrapper__form__bottom__result__comments').css("display", "block");
  });


});
