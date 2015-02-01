'use strict'
$ ->
  $('input.form-control').focusout ->
    sender = $(@)
    target = sender.closest('.form-group')
    if sender.val() is ''
      target.removeClass 'has-success'
      target.addClass 'has-error'
    else
      target.removeClass 'has-error'
      target.addClass 'has-success'

  validate = ->
    isValid = true
    $('input.form-control').each (i, elem) ->
      if not elem.value
        isValid = false

    return isValid

  $('#btn-create').click ->
    form = $(@).closest('form')
    url = form.prop "action"
    data = form.serialize()

    if validate()
      $.post(url, data, -> window.location.reload())
    else
      alert 'Username and Password are required fields.'
