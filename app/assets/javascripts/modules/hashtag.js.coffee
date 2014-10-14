$ ->

  # $.isElementInViewport = (el) ->
  #   #special bonus for those using jQuery
  #   el = el[0] if el instanceof jQuery
  #   rect = el.getBoundingClientRect()
  #   #or $(window).height() 
  #   rect.top >= 0 and 
  #   rect.left >= 0 and 
  #   rect.bottom <= (window.innerHeight or document.documentElement.clientHeight) and
  #   rect.right <= (window.innerWidth or document.documentElement.clientWidth) #or $(window).width()






  # $.isElementOutsideViewport = (el, offsetHide, offsetRemove) ->
    
  #   #special bonus for those using jQuery
  #   el = el[0] if el instanceof jQuery
  #   rect = el.getBoundingClientRect()
  #   #or $(window).height() 
    
  #   rectTop = rect.top
  #   rectBottom = rect.bottom
  #   height = (window.innerHeight or document.documentElement.clientHeight)

  #   hide:   (rectTop < 0 - offsetHide) or (rectBottom > height + offsetHide)
  #   remove: (rectTop < 0 - offsetRemove) or (rectBottom > height + offsetRemove)
                  

  # visibilityFn = ->
  #   $('.media-card').each (index, elem) ->
  #     ele = $(elem)
  #     isOutsideBoundaries = $.isElementOutsideViewport(elem, 3000, 6000)

  #     if isOutsideBoundaries.remove
  #       ele.remove()

  #     if isOutsideBoundaries.hide
  #       if !ele.hasClass('hidden')
  #           ele.addClass('hidden')
  #     else
  #       if ele.hasClass('hidden')
  #           ele.removeClass('hidden')  

  #     # $(elem).toggleClass('hidden', $.isElementOutsideViewport(elem, 5000))















  $.isElementOutsideViewport = (el, offset) ->
    
    #special bonus for those using jQuery
    el = el[0] if el instanceof jQuery
    rect = el.getBoundingClientRect()
    #or $(window).height() 
    rect.top < 0 - offset or 
    rect.bottom > (window.innerHeight or document.documentElement.clientHeight) + offset

  visibilityFn = ->
    # console.log 'HIDING'

    $('.media-card-container').each (index, elem) ->
      shouldHide = $.isElementOutsideViewport(elem, 1000)
      $(elem).toggleClass('hidden', shouldHide).find('.media-card-tile-visible').toggleClass('media-card-loaded', !shouldHide)


      # ele = $(elem)
      # if ele.hasClass('hidden')
      #   ele.removeClass('hidden').find('.media-card-tile-visible').addClass('media-card-loaded') if !shouldHide
      # else
      #   ele.addClass('hidden').find('.media-card-tile-visible').removeClass('media-card-loaded') if shouldHide


      # visibleTile = .toggleClass('hidden', shouldHide).find('.media-card-tile-visible').toggleClass('media-card-loaded', !shouldHide)

      # if !shouldHide
      #   visibleTile.css('background-image', 'url("' + visibleTile.data().uri + '")')
      # else
      #   visibleTile.css('background-image', 'none')

    # toHide = []
    # toReveal = []

    # $('.media-card').each (index, elem) ->
    #   ele = $(elem)
    #   if $.isElementOutsideViewport(elem, 500)
    #     toHide.push(ele)
    #   else if ele.hasClass('hidden')
    #     toReveal.push(ele)

    # if toHide.length
    #   console.log 'HIDING', toHide.length
    #   debugger
    #   toHide.each (index, elem) -> 

    #   $(toHide).addClass('hidden').find('.media-card-tile-visible').removeClass('media-card-loaded')
    # if toReveal.length
    #   console.log 'REVEALING', toReveal.length
    #   $(toReveal).removeClass('hidden').find('.media-card-tile-visible').addClass('media-card-loaded')


  # moveToCentralCard = (cards)->

  #   inViewports = cards.filter((index, elem) ->
  #     !$.isElementOutsideViewport(elem, 5000))

  #   console.log cards.length
  #   console.log inViewports.length

  #   middle = inViewports.first();

  #   $('html,body').animate({
  #       scrollTop: middle.offset().top
  #     }, 1000);


  # removeFn = ->
  #   cards = $('.media-card')
  #   toRemove = cards.filter((index, elem) ->
  #     $.isElementOutsideViewport(elem, 5000))
  #   # .slice(-12)

  #   if toRemove.length
  #     window.noScroll()
  #     console.log 'REMOVING', toRemove.length
  #     # toRemove.removeClass('media-card').find('.media-card-container').empty()
  #     toRemove.remove();
  #     window.canScroll()


      # moveToCentralCard(cards)

  scrollFn = ->
    distanceY = window.pageYOffset or document.documentElement.scrollTop
    shrinkOn = 300
    $('header').toggleClass 'smaller', distanceY > shrinkOn
    $('.nav-drawer').removeClass 'opened' if distanceY > shrinkOn

  # resizeFn = ->
  #   console.log()
  #   visibilityFn()

  scrollHandler = ->
    # removeFn()
    visibilityFnRateLimit()
    scrollFn()

  resizeLongFlashFn = ->
    # console.log('long-resize')
    $('.nav-drawer').removeClass 'opened'
    # $('.media-card-tile-visible.media-card-loaded').removeClass('media-card-loaded')
    # visibilityFnRateLimit()



  resizeLongFlashFnRateLimit = $.throttle(resizeLongFlashFn, 2500)
  scrollHandlerRateLimit = $.throttle(scrollHandler, 500)
  visibilityFnRateLimit = $.debounce(visibilityFn, 250)

  $(window).scroll scrollHandlerRateLimit
  $(window).resize visibilityFnRateLimit
  $(window).resize resizeLongFlashFnRateLimit




  container = $('#instagram-media-cards .media-cards')
  
  infinitescrollOptions = 
    navSelector:  'nav.pagination'             # selector for the paged navigation (it will be hidden)
    nextSelector: 'nav.pagination a[rel=next]' # selector for the NEXT link (to page 2)
    itemSelector: '.media-card'      # selector for all items you'll retrieve
    loading:
      finishedMsg: ''
      img:         'javascript:void(0)'
      msg:         null
      msgText:     ''
    # extraScrollPx: 350
    bufferPx:      700

  applyImageOpacity = (container) ->

    $(container).find('.media-card-tile-visible').imagesLoaded (elems) ->
      $(this).addClass('media-card-loaded')
    # $(container).find('.media-card-tile-visible').each (elem) ->
    #   $(this).imagesLoaded -> 
    #     rand = Math.floor(Math.random() * 17) + 1
    #     $(this).addClass('media-card-loaded').addClass('media-card-loaded-' + rand)

    
    window.addSubMorphs($(container).find('.morph-button').get())


  retrieveMore = -> container.infinitescroll 'retrieve'

  container.infinitescroll infinitescrollOptions, applyImageOpacity
  # setTimeout retrieveMore, 100
  # setTimeout retrieveMore, 250
  # setTimeout retrieveMore, 500
  # setTimeout retrieveMore, 750


  applyImageOpacity container

  # container.imagesLoaded ->
  #   console.log 'all images loaded'


  # gridItemWidth = () -> $('.media-card:not(.media-card-expanded)').first().width()

  # gridAcrossCount = () ->
  #   screenWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth || 0
  #   count = Math.round(screenWidth / gridItemWidth() )
  #   count = 12 if count > 12

  # shuffleCards = (currentCard) ->

  #   before = currentCard.prevAll()
  #   after = currentCard.nextAll()

  #   acrossCount = gridAcrossCount()
  #   beforeCount = before.length
  #   afterCount = after.length

  #   amountToMoveBefore = beforeCount % acrossCount
  #   amountToMoveAfter = acrossCount - amountToMoveBefore

  #   console.log acrossCount

  #   console.log beforeCount, amountToMoveBefore
  #   console.log afterCount, amountToMoveAfter


  #   if amountToMoveBefore is 0
  #     return
  #   else if beforeCount >= amountToMoveBefore
  #     before.slice(-1 * amountToMoveBefore).insertAfter currentCard
  #   else if afterCount >= amountToMoveAfter
  #     after.slice(amountToMoveAfter).insertBefore currentCard
  #   else if amountToMoveBefore isnt 0
  #     before.insertAfter currentCard




    # shiftRightCount = beforeCount % gridAcrossCount()
    # shiftLeftCount = (beforeCount % gridAcrossCount()) * 2


  # TODO: RESIZE BINDING





  # $('body').on 'click', '.media-card', (e) ->
  #   e.preventDefault()
  #   e.stopPropagation()

  #   currentCard = $(this)

  #   if currentCard.hasClass('media-card-expanded')
  #     currentCard.removeClass('media-card-expanded')
  #   else
  #     img = currentCard.find('.media-card-tile-image img')
  #     # img.attr('src', img.data().uri)
  #     img.imagesLoaded -> $(this).addClass('media-card-tile-image-loaded')

  #     $('.media-card').removeClass('media-card-expanded')
  #     currentCard.addClass('media-card-expanded')

  #     shuffleCards(currentCard)

  #     $.scrollTo(currentCard)



  # $('body').on 'mouseenter', '.media-card', (e) -> 
  

  #   self = $(this)

  #   img = self.find('.media-card-tile-image img')
  #   if img.length
  #     img.attr('src', img.data().uri)
  #     img.imagesLoaded -> $(this).addClass('media-card-tile-image-loaded')

  #   img = self.find('.media-card-author img')
  #   img.attr('src', img.data().uri)
  #   img.imagesLoaded -> $(this).addClass('media-card-tile-image-loaded')


      # shiftNearby();

      # elemsWithUnderSpacing = $('.media-card').filter -> Math.abs($(this).height() - $(this).width()) > 2
      # # elemsProperlySpaced   = $('.instagram_media-card').filter -> $(this).height() <= $(this).width()

      # elemsWithUnderSpacing.each (elem)-> 
      #   elemsProperlySpaced = $('.instagram_media-card').filter -> Math.abs($(this).height() - $(this).width()) <= 2
      #   elemsProperlySpaced.last().insertBefore $(this)


      # debugger


  # $('body').on 'click', '.media-card-tile-image', (e) ->
  #   e.preventDefault()
  #   e.stopPropagation()


  # container.masonry(
  #   itemSelector: '.media-card'
  #   columnWidth: 100
  #   gutterWidth: 90
  # }


  # container.isotope
  #   itemSelector: '.media-card'
  #   layoutMode:   'fitRows'



  # $('.media-card').clone().appendTo('.page')
  # $('.media-card').clone().appendTo('.page')
  # $('.media-card').clone().appendTo('.page')
  # $('.media-card').clone().appendTo('.page')
