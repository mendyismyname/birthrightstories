$ ->
  menu = $("#navigation-menu")
  menuToggle = $("#js-mobile-menu")
  signUp = $(".sign-up")
  menuToggle.on "click", (e) ->
    e.preventDefault()
    menu.slideToggle ->
      menu.removeAttr "style" if menu.is(":hidden")

  
  # underline under the active nav item
  $(".nav .nav-link").click ->
    $(".nav .nav-link").each ->
      $(this).removeClass "active-nav-item"

    $(this).addClass "active-nav-item"
    $(".nav .more").removeClass "active-nav-item"


  window.addEventListener 'scroll', (e) ->
    distanceY = window.pageYOffset or document.documentElement.scrollTop
    shrinkOn = 300
    $('header').toggleClass 'smaller', distanceY > shrinkOn


  $('.instagram-media-card').clone().appendTo('.page')
  $('.instagram-media-card').clone().appendTo('.page')
  $('.instagram-media-card').clone().appendTo('.page')
  $('.instagram-media-card').clone().appendTo('.page')
