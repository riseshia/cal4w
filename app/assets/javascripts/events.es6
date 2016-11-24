$(document).on("turbolinks:load", () => {
  if ($(".summernote").length && !$(".note-editor").length) {
    $(".summernote").summernote({ height: 300 })
  }
})
