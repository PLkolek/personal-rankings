# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#new_comment').submit( (e) ->
    e.preventDefault()
    $.post('/posts/20/comments', $('#new_comment').serialize(), (comment) ->
      content = '<div class="comment"><i>'+comment.created_at+'</i>'
      content+= '<div class="comment-content">'+comment.content+'</div></div>'
      if $('.comment').length==0
        $('.post-content').after(content)
      else
        $('.comment').last().after(content)
    , 'json')
  )
