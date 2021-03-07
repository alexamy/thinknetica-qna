function addEditLinks() {
  $('.question').on('click', '.edit-question-link', function(e) {
    e.preventDefault();
    $(this).hide();

    const questionId = $(this).data('questionId');
    $(`form#edit-question-${questionId}`).show();
  });
}

$(document).on('turbolinks:load', function() {
  addEditLinks();
});
