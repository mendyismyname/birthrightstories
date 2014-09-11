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

  $.isElementOutsideViewport = (el, offset) ->
    
    #special bonus for those using jQuery
    el = el[0] if el instanceof jQuery
    rect = el.getBoundingClientRect()
    #or $(window).height() 
    rect.top < 0 - offset or 
    rect.bottom > (window.innerHeight or document.documentElement.clientHeight) + offset

  visibilityFn = ->
    $('.media-card').each (index, elem) ->
      $(elem).toggleClass('hidden', $.isElementOutsideViewport(elem, 1500))

  scrollFn = ->
    distanceY = window.pageYOffset or document.documentElement.scrollTop
    shrinkOn = 300
    $('header').toggleClass 'smaller', distanceY > shrinkOn
    $('.nav-drawer').removeClass 'opened' if distanceY > shrinkOn


  window.addEventListener 'scroll', $.throttle(visibilityFn, 150)

  window.addEventListener 'scroll', $.throttle(scrollFn, 200)










  container = $('#instagram-media-cards .media-cards')
  
  infinitescrollOptions = 
    navSelector:  'nav.pagination'             # selector for the paged navigation (it will be hidden)
    nextSelector: 'nav.pagination a[rel=next]' # selector for the NEXT link (to page 2)
    itemSelector: '.media-card'      # selector for all items you'll retrieve
    loading:
      finishedMsg: ''
      # img:         null
      msg:         null
      msgText:     ''
    # extraScrollPx: 350
    bufferPx:      1500

  applyImageOpacity = (container) ->
    fn = () ->
      $(container).find('.media-card-tile-visible').each (elem) ->
        $(this).imagesLoaded -> 
          $(this).addClass('media-card-loaded')

      # new Share '.media-card-social', 
      #   networks: 
      #     facebook: 
      #       app_id: 'abc123'

    setTimeout fn, 1

  retrieveMore = -> container.infinitescroll 'retrieve'

  container.infinitescroll infinitescrollOptions, applyImageOpacity
  setTimeout retrieveMore, 1
  setTimeout retrieveMore, 250
  setTimeout retrieveMore, 500
  # setTimeout retrieveMore, 750


  applyImageOpacity container

  # container.imagesLoaded ->
  #   console.log 'all images loaded'


  gridItemWidth = () -> $('.media-card:not(.media-card-expanded)').first().width()

  gridAcrossCount = () ->
    screenWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth || 0
    count = Math.round(screenWidth / gridItemWidth() )
    count = 12 if count > 12

  shuffleCards = (currentCard) ->

    before = currentCard.prevAll()
    after = currentCard.nextAll()

    acrossCount = gridAcrossCount()
    beforeCount = before.length
    afterCount = after.length

    amountToMoveBefore = beforeCount % acrossCount
    amountToMoveAfter = acrossCount - amountToMoveBefore

    console.log acrossCount

    console.log beforeCount, amountToMoveBefore
    console.log afterCount, amountToMoveAfter


    if amountToMoveBefore is 0
      return
    else if beforeCount >= amountToMoveBefore
      before.slice(-1 * amountToMoveBefore).insertAfter currentCard
    else if afterCount >= amountToMoveAfter
      after.slice(amountToMoveAfter).insertBefore currentCard
    else if amountToMoveBefore isnt 0
      before.insertAfter currentCard




    # shiftRightCount = beforeCount % gridAcrossCount()
    # shiftLeftCount = (beforeCount % gridAcrossCount()) * 2


  # TODO: RESIZE BINDING





  $('body').on 'click', '.media-card', (e) ->
    e.preventDefault()
    e.stopPropagation()

    currentCard = $(this)

    if currentCard.hasClass('media-card-expanded')
      currentCard.removeClass('media-card-expanded')
    else
      img = currentCard.find('.media-card-tile-image img')
      # img.attr('src', img.data().uri)
      img.imagesLoaded -> $(this).addClass('media-card-tile-image-loaded')

      $('.media-card').removeClass('media-card-expanded')
      currentCard.addClass('media-card-expanded')

      shuffleCards(currentCard)

      # $.scrollTo(currentCard)



  $('body').on 'mouseenter', '.media-card', (e) -> 
  
    img = $(this).find('.media-card-tile-image img')
    img.attr('src', img.data().uri)
    img.imagesLoaded -> $(this).addClass('media-card-tile-image-loaded')


      # shiftNearby();

      # elemsWithUnderSpacing = $('.media-card').filter -> Math.abs($(this).height() - $(this).width()) > 2
      # # elemsProperlySpaced   = $('.instagram_media-card').filter -> $(this).height() <= $(this).width()

      # elemsWithUnderSpacing.each (elem)-> 
      #   elemsProperlySpaced = $('.instagram_media-card').filter -> Math.abs($(this).height() - $(this).width()) <= 2
      #   elemsProperlySpaced.last().insertBefore $(this)


      # debugger




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
