#= require jquery
#= require jquery_ujs
#= require js.cookie
#= require semantic-ui
#= require turbolinks
#= require simditor
#= require particles.js/particles.js
#= require_tree .

$(document).on 'turbolinks:load', ->
  # Semantic-UI
  # Initialize dropdown module
  $('.dropdown').dropdown()

  # Initialize tab module
  $('.tabular.menu .item').tab()

  # Initialize dismissable message collection
  $('.message .close').on 'click', ->
    $(this).closest('.message').fadeOut()

  # replace rails default error tags with semantic-ui error classes
  error_fields = $('.field_with_errors')
  error_fields.parent('.field').addClass 'error'
  error_fields.children().unwrap()

  $('#new-folder-modal').modal('attach events', '#new-folder-btn', 'show')
  $('#new-file-modal').modal('attach events', '#new-file-btn', 'show')
  $('.ui.checkbox').checkbox()
