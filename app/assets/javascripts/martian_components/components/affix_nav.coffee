class @Components.AffixNav extends @Components.Base
  @autoInit: ->
    $('.component-affix_nav').each (i, el) => new @($(el))

  constructor: (@el) ->
    @breakpoints =
      sm: 600
      md: 900

    super

    @init()
    @fixWidth()
    @scrollOnClick()
    @scrollOnLoad()
    $(window).resize @fixWidth

  init: ->
    @el.css 'margin-left', '-9999px'
    setTimeout =>
      @el.affix
        offset:
          top: @el.parent().offset().top

      @el.css 'margin-left', '0'

      $('body').scrollspy
        target: @el.selector

    , 500

  scrollOnClick: ->
    # Based on http://css-tricks.com/snippets/jquery/smooth-scrolling/
    $('a[href*=#]:not([href=#])', @el).on 'click', (ev) =>
      if location.pathname.replace(/^\//,'') == ev.target.pathname.replace(/^\//,'') && location.hostname == ev.target.hostname
        @scrollTo @getTargetByHash(ev.target.hash)

  scrollOnLoad: ->
    setTimeout =>
      @scrollTo @getTargetByHash(location.hash)
    , 500

  scrollTo: (target) ->
    return unless target.length

    $('html,body').animate({
      scrollTop: target.offset().top
    }, 1000)
    false

  getTargetByHash: (hash) ->
    if $(hash).length then $(hash) else $("[name='#{hash.slice(1)}']")

  fixWidth: =>
    @el.css 'width', @el.parent().width()
