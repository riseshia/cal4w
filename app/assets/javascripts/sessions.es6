$(document).on("ready turbolinks:load", () => {
  $("#users_sign_in").on("keyup", () => validator("validate"))
})
