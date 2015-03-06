//= require jquery
//= require jquery_ujs
//= require semantic-ui
//= require turbolinks
//= require froala_editor.min.js
//= require_tree .

$(document).on("ready page:load", function() {
  // Initialize semantic-ui sidebar module
  $('.sidebar-toggle').click(function(){
    $('.sidebar').sidebar('toggle');
  })

  // Initialize semantic-ui dropdown module
  $('.dropdown').dropdown();

  // replace rails default error tags with semantic-ui error classes
  var error_fields = $('.field_with_errors');
  error_fields.parent('.field').addClass("error");
  error_fields.children().unwrap();

  // Initialize Froala WYSIWYG editor
  $('.editor').editable({
    inlineMode: false,
    height: 300
  });
  // Replace Font-awesome classes with semantic-ui icon classes
  // in Froala editor.
  var fa_classes = {
    'fa-bold':'bold icon',
    'fa-italic':'italic icon',
    'fa-underline':'underline icon',
    'fa-strikethrough':'strikethrough icon',
    'fa-paragraph':'paragraph icon',
    'fa-align-left':'alig left icon',
    'fa-align-center':'align center icon',
    'fa-align-right':'align right icon',
    'fa-align-justify':'align justify icon',
    'fa-dedent':'outdent icon',
    'fa-indent':'indent icon',
    'fa-link':'linkify icon',
    'fa-picture-o':'picture outline icon',
    'fa-minus':'minus icon',
    'fa-undo':'undo icon',
    'fa-repeat':'repeat icon',
    'fa-code':'code icon',
    'fa-times':'remove icon'
  };
  for(i in fa_classes) {
    $('.' + i).addClass(fa_classes[i]);
  }

});
