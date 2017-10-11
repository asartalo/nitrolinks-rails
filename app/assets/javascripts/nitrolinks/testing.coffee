whenReady = (fn) ->
  if (if document.attachEvent then document.readyState == 'complete' else document.readyState != 'loading')
    fn()
  else
    document.addEventListener "DOMContentLoaded", ->
      fn()

select = (selector) ->
  selectAll(selector)[0]

selectAll = (selector) ->
  document.querySelectorAll(selector)

eventListen = (event, handler) ->
  document.addEventListener event, (e) ->
    handler.call document, e

last = (collection) ->
  if collection.length > 0
    collection[collection.length - 1]

class NitrolinksTesting
  constructor: (@window, @document) ->
    @active = false
    @store = new NitrolinksTestStore(@window.localStorage)
    @domLoadKey = 'nitroDomLoad'
    @fetchLoadKey = 'nitroFetchLoad'
    @cacheLoadKey = 'nitroCacheLoad'
    @loadCount = 0
    @errors = []

  init: ->
    @listen()

  body: ->
    select('body')

  listen: ->
    loads = (e) =>
      @loadCount += 1
      @showDebugData()

    eventListen 'nitrolinks:load', loads
    eventListen 'nitrolinks:load-blank', loads

    eventListen 'nitrolinks:load-from-fetch', (e) =>
      @addToFetched(e.detail.url)

    eventListen 'nitrolinks:load-from-cache', (e) =>
      @addToCached(e.detail.url)

    @window.addEventListener 'error', (e) =>
      @addToErrors(e)

    whenReady =>
      return unless select('#nitro-debugging')
      @addToLoaded(@window.location.href)
      @showDebugData()

  addToFetched: (url) ->
    @addToArrayStored(@fetchLoadKey, url)

  addToLoaded: (url) ->
    @addToArrayStored(@domLoadKey, url)

  addToCached: (url) ->
    @addToArrayStored(@cacheLoadKey, url)

  addToArrayStored: (key, input) ->
    loads = @store.get(key, [])
    loads.push input
    @store.set(key, loads)

  addToErrors: (e) ->
    if e.error
      @errors.push e.error.message
    else
      @errors.push e
    console.log e
    @loadShowerFromCollection(@errorsEl(), @errors)

  showDebugData: ->
    if select('#nitro-debugging')
      @showNitroLoadCount()
      @showDomLoads()
      @showFetchLoads()
      @showCacheLoads()

  showNitroLoadCount: ->
    select('#nitro-debugging .nitro-load-count').textContent = @loadCount

  errorsEl: ->
    select('#nitro-debugging .javascript-errors')

  domEl: ->
    select('#nitro-debugging .dom-loads')

  showDomLoads: ->
    @loadShowerFromCollection(@domEl(), @errors)

  loadShower: ($el, storeKey) ->
    @loadShowerFromCollection($el, @store.get(storeKey, []))

  loadShowerFromCollection: ($el, loads) ->
    htmlStr = ''
    for load in loads
      htmlStr += "<li>#{load}</li>"
    $el.innerHTML = htmlStr

  fetchEl: ->
    select('#nitro-debugging .fetch-loads')

  showFetchLoads: ->
    @loadShower(@fetchEl(), @fetchLoadKey)

  cacheEl: ->
    select('#nitro-debugging .cache-loads')

  showCacheLoads: ->
    @loadShower(@cacheEl(), @cacheLoadKey)

  clearDomLoads: ->
    @store.remove(@domLoadKey)
    @clearSessionLoads()

  clearSessionLoads: ->
    @store.remove(@fetchLoadKey)
    @store.remove(@cacheLoadKey)

  domLoadCount: ->
    @store.get(@domLoadKey, []).length

  isPageFetched: (path) ->
    @compareItem(@fetchEl(), path)

  isPageNormallyLoaded: (path) ->
    @compareItem(@domEl(), path, (item) ->
      @urlPath(item.textContent)
    )

  isPageCacheRestored: (path) ->
    @compareItem(@cacheEl(), path)

  compareItem: (el, path, comparator) ->
    comparator ||= (item) ->
      item.textContent
    lastItem = last(el.querySelectorAll('li'))
    if lastItem
      comparator(lastItem) == path
    else
      false

  urlPath: (urlStr) ->
    url = new URL(urlStr)
    if url.origin == url.toString()
      url.pathname
    else
      url.toString().replace(url.origin, '')

  hasJavascriptErrors: ->
    @errorsEl().querySelectorAll('li').length > 0

class NitrolinksTestStore
  constructor: (@localStore) ->

  set: (key, value) ->
    @localStore.setItem(key, JSON.stringify(value))

  get: (key, def = null) ->
    stored = @localStore.getItem(key)
    if stored
      JSON.parse stored
    else
      def

  remove: (key) ->
    @localStore.removeItem(key)

whenReady =>
  @nitroTesting = new NitrolinksTesting(window, document)
  @nitroTesting.init()

