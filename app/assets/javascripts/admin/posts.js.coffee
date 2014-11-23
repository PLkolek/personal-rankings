# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#ranking").sortable(
    start: (e, ui) ->
      $(ui.placeholder).hide(200)
    change: (e,ui) ->
      $(ui.placeholder).hide().show(200)
    out: (e,ui) ->
      $(ui.placeholder).show(200)
    cancel: 'li:not(#new-item)'
    update: (e, ui) ->
      $('#post_position').val(ui.item.index())
  );
  $("#ranking").disableSelection();

  $("#new-items").sortable(
    start: (e, ui) ->
      $(ui.placeholder).hide(200)
    change: (e,ui) ->
      $(ui.placeholder).hide().show(200)
    out: (e,ui) ->
      $(ui.placeholder).show(200)
    connectWith: '#ranking'
  );
  $("#new-items").disableSelection();
  $('#post_title').on('input',  ->
    $('#new-item').text($('#post_title').val()))