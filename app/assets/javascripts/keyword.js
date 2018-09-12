$(function() {
  $('#keyword-class-news').on('click', function() {
    $(this).css("color", "#4277FB");
    $(this).css("border-bottom", "2px solid #4277FB");
    $(this).css("font-weight", "bold");
    $('#keyword-class-comment').css("color", "#999");
    $('#keyword-class-comment').css("border-bottom", "2px solid #fff");
    $('#keyword-class-comment').css("font-weight", "normal");
    $('.keyword-wrapper__form__bottom__result__comments').css("display", "none");
    $('.keyword-wrapper__form__bottom__result__picks').css("display", "block");
  });
  $('#keyword-class-comment').on('click', function() {
    $(this).css("color", "#4277FB");
    $(this).css("border-bottom", "2px solid #4277FB");
    $(this).css("font-weight", "bold");
    $('#keyword-class-news').css("color", "#999");
    $('#keyword-class-news').css("border-bottom", "2px solid #fff");
    $('#keyword-class-news').css("font-weight", "normal");
    $('.keyword-wrapper__form__bottom__result__picks').css("display", "none");
    $('.keyword-wrapper__form__bottom__result__comments').css("display", "block");
  });

  $('.fixed_keyword').on('click', function() {
    $('.keyword-wrapper').css("display", "block");
    $('.keyword-wrapper__form__above__input').css("display", "none");
    $('.keyword-wrapper__form__above__keyword').css("display", "block");
    $('.keyword-wrapper__form__bottom__announce').css("display", "none");
    $('.keyword-wrapper__form__bottom__result').css("display", "block");
    $('.keyword-wrapper__overlay').on('click', function(e) {
      if (e.target.className == "keyword-wrapper__overlay") {
        $('.keyword-wrapper').css("display", "none");
        $('.keyword-wrapper__form__above__keyword').css("display", "none");
        $('.keyword-wrapper__form__above__input').css("display", "block");
        $('.keyword-wrapper__form__bottom__result').css("display", "none");
        $('.keyword-wrapper__form__bottom__announce').css("display", "block");
      }
    });
  });

});
