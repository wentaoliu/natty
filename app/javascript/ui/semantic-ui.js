import 'jquery/src/jquery'
import 'semantic-ui/dist/semantic.css'
import 'semantic-ui/dist/semantic.js'

$(document).on('turbolinks:load', function() {
  // Semantic-UI
  // Initialize dropdown module
  $('.dropdown').dropdown()

  // Initialize tab module
  $('.tabular.menu .item').tab()

  // Initialize dismissable message collection
  $('.message .close').on('click', function() {
    $(this).closest('.top-fixed-message').transition('fade')
  })
  // replace rails default error tags with semantic-ui error classes
  let error_fields = $('.field_with_errors')
  error_fields.parent('.field').addClass('error')
  error_fields.children().unwrap()

  $('#new-folder-modal').modal('attach events', '#new-folder-btn', 'show')
  $('#new-file-modal').modal('attach events', '#new-file-btn', 'show')
  $('.ui.checkbox').checkbox()
})