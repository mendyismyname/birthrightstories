(function() {
  var docElem = window.document.documentElement, didScroll, scrollPosition;

  // trick to prevent scrolling when opening/closing button
  window.noScrollFn = function() {
    window.scrollTo( scrollPosition ? scrollPosition.x : 0, scrollPosition ? scrollPosition.y : 0 );
  }

  window.noScroll = function() {
    window.removeEventListener( 'scroll', scrollHandler );
    window.addEventListener( 'scroll', noScrollFn );
  }

  window.scrollFn = function() {
    window.addEventListener( 'scroll', scrollHandler );
  }

  window.canScroll = function() {
    window.removeEventListener( 'scroll', noScrollFn );
    scrollFn();
  }

  window.scrollHandler = function() {
    if( !didScroll ) {
      didScroll = true;
      setTimeout( function() { scrollPage(); }, 60 );
    }
  };

  window.scrollPage = function() {
    scrollPosition = { x : window.pageXOffset || docElem.scrollLeft, y : window.pageYOffset || docElem.scrollTop };
    didScroll = false;
  };

  scrollFn();

  // $('body').on('click', '.morph-button' , function(e){
  // });

  window.addSubMorphs = function(elems){
    [].slice.call( elems ).forEach( function( bttn ) {
      new UIMorphingButton( bttn, {
        closeEl : '.icon-close',
        onBeforeOpen : (function(btn) {

          return function(){


            elem = $(btn)

            var img = elem.find('.media-card-tile-image img')
            if(img.length){

              img.attr('src', img.data().uri)
              img.imagesLoaded(function() {
                $(this).addClass('media-card-tile-image-loaded');
              });
            }

            img = elem.find('.media-card-author img')
            img.attr('src', img.data().uri)
            img.imagesLoaded(function() {
              $(this).addClass('media-card-tile-image-loaded');
            });

            var video = elem.find('.media-card-tile-image video');

            if(video.length){
              video.attr('src', video.data().uri);
              video.imagesLoaded(function(){
                $(this).addClass('media-card-tile-image-loaded');
              });
            }
            new Share('.media-card-social');
            
            // don't allow to scroll
            noScroll();

            // Close header
            $('#header-learn').removeClass('opened');

          };
        })(bttn),
        onAfterOpen : function() {
          // can scroll again
          canScroll();
        },
        onBeforeClose : (function(btn) {

          return function(){
            var video = $(btn).find('.media-card-tile-image video');

            if(video.length){
              video.attr('src', 'javascript:void(0)');
            }
            // don't allow to scroll
            noScroll();
          };
        })(bttn),
        onAfterClose : function() {
          // can scroll again
          canScroll();
        }
      } );
    } );
  }
  window.addSubMorphs(document.querySelectorAll( '.morph-button' ));

  // for demo purposes only
  // [].slice.call( document.querySelectorAll( 'form button' ) ).forEach( function( bttn ) { 
  //   bttn.addEventListener( 'click', function( ev ) { ev.preventDefault(); } );
  // } );
})();  