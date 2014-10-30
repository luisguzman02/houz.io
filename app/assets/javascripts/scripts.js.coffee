$(document).ready ->
  $("#enableForm").bootstrapValidator
    feedbackIcons:
      valid: "glyphicon glyphicon-ok"
      invalid: "glyphicon glyphicon-remove"
      validating: "glyphicon glyphicon-refresh"

    fields:
      name:
        validators:
          notEmpty:
            message: "The full name is required and cannot be empty"

      telephone:
        validators: {}

      email:
        validators:
          notEmpty:
            message: "The email is required and cannot be empty"

          regexp:
            regexp: /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
            message: "The input is not a valid email address"

      message:
        validators:
          notEmpty:
            message: "The message is required and cannot be empty"
