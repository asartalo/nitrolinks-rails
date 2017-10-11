whenReady = (fn) ->
  if (if document.attachEvent then document.readyState == 'complete' else document.readyState != 'loading')
    fn()
  else
    document.addEventListener "DOMContentLoaded", ->
      fn()

eventListen = (event, handler) ->
  document.addEventListener event, (e) ->
    handler.call document, e

class NitrolinksLoadHelper
  constructor: (@window, @document) ->
    @active = false

  body: ->
    document.querySelector('body')

  markAsLoading: (from)->
    @active = true
    @body().classList.add('testing-visiting')

  markAsDoneLoading: ->
    @active = false
    @body().classList.remove('testing-visiting')

  listen: ->
    eventListen 'nitrolinks:visit', =>
      @markAsLoading('nitrolinks:visit')

    loads = (e) =>
      @markAsDoneLoading()

    eventListen 'nitrolinks:load', loads
    eventListen 'nitrolinks:load-blank', loads

whenReady =>
  @nitroLoadHelper = new NitrolinksLoadHelper(window, document)
  @nitroLoadHelper.listen()
  @nitroLoadHelper.markAsDoneLoading()


