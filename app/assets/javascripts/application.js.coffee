#= require jquery
#= require jquery_ujs
#= require jquery.cookie
#= require semantic-ui
#= require turbolinks
#= require simditor
#= require particles.js/particles.js
#= require_tree .

$(document).on 'ready page:load', ->
  # Semantic-UI
  # Initialize sidebar module
  $('.left-sidebar-toggle').click ->
    $('.sidebar.left').sidebar 'toggle'

  # Initialize popup module
  $('.right.menu > .item').popup position: 'bottom right'
  $('.locale').popup position: 'bottom left'

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

  particlesJS.load 'canvas', 'assets/particles.json'
