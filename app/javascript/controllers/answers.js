function addEditLinks() {
  $('.answers').on('click', '.edit-answer-link', function(e) {
    e.preventDefault();
    $(this).hide();

    const answerId = $(this).data('answerId');
    $(`form#edit-answer-${answerId}`).show();
  });
}

function addDeleteLinks() {
  $('.answers').on('click', '.delete-answer-link', function(e) {
     const answerId = $(this).data('answerId');
     $(`#answer-${answerId}`).remove();
  });
}

function addChooseAsBestLinks() {
  $('.answers').on('click', '.choose-best-answer-link', function(e) {
    $('.best-answer .choose-best-answer-link').show();
    $('.best-answer').removeClass('best-answer');

    $(this).hide();
    $(this).parents('.answer').addClass('best-answer');
  });
}

$(document).on('turbolinks:load', function() {
  addEditLinks();
  addDeleteLinks();
  addChooseAsBestLinks();
});
