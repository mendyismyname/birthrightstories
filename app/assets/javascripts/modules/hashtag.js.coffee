$ ->
  container = $('#instagram-media-cards .page')

  container.infinitescroll
    navSelector:  'nav.pagination'             # selector for the paged navigation (it will be hidden)
    nextSelector: 'nav.pagination a[rel=next]' # selector for the NEXT link (to page 2)
    itemSelector: '.instagram-media-card'      # selector for all items you'll retrieve
    loading:
      finishedMsg: ''
      img:         'http://i.imgur.com/6RMhx.gif'

  container.imagesLoaded ->
    console.log 'all images loaded'
