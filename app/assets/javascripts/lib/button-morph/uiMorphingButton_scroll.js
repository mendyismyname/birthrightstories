(function() {
  var docElem = window.document.documentElement, didScroll, scrollPosition;

  window.scrollPage = function() {
    scrollPosition = { x : window.pageXOffset || docElem.scrollLeft, y : window.pageYOffset || docElem.scrollTop };
    didScroll = false;
  };

  window.scrollHandler = function() {
    if( !didScroll ) {
      didScroll = true;
      setTimeout( function() { window.scrollPage(); }, 60 );
    }
  };

  // trick to prevent scrolling when opening/closing button
  window.noScrollFn = function() {
    window.scrollTo( scrollPosition ? scrollPosition.x : 0, scrollPosition ? scrollPosition.y : 0 );
  }

  window.noScroll = function() {
    // console.log('no scroll')
    window.removeEventListener( 'scroll', window.scrollHandler );
    window.addEventListener( 'scroll', window.noScrollFn );
  }

  window.scrollFn = function() {
    window.addEventListener( 'scroll', window.scrollHandler );
  }

  window.canScroll = function() {
    // console.log('can scroll')
    window.removeEventListener( 'scroll', window.noScrollFn );
    window.scrollFn();
  }

  window.scrollFn();

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

            var authorImg = elem.find('.media-card-author img')
            authorImg.attr('src', authorImg.data().uri)
            authorImg.imagesLoaded(function() {
              $(this).addClass('media-card-tile-image-loaded');
            });

            var video = elem.find('.media-card-tile-image video');

            if(video.length){
              video.attr('src', video.data().uri);
              video.imagesLoaded(function(){
                $(this).addClass('media-card-tile-image-loaded');
              });
            }

            var locationURI = window.location.href.split('?').shift() + '?autoexpand_id=' + elem.parent().parent().attr('id').replace('media-card-', '');
            var headline = encodeURIComponent(['400,000', $('.nav-headline h5').html()].join(' '));
            var caption = encodeURIComponent(elem.find('.media-card-caption').html().trim());
            var username = encodeURIComponent(elem.find('.media-card-author p').html().trim());

            var shareConfig = {
              url: locationURI,
              image: video.length ? video.data().photo : img.data().uri,
              title: [headline, caption, username].join(' '),
              description: [caption, username].join(' '),
              // ui: {
              //  flyout: 'top left'
              // },
              networks: {
                twitter: {
                  enabled: true
                },
                facebook: {
                  enabled: true,
                  app_id: 717106305044262,
                  title: decodeURIComponent(headline),
                  description: decodeURIComponent([caption, username, locationURI].join(' '))
                },
                email: {
                  enabled: true,
                  title: headline,
                  description: [caption, username, locationURI].join(' ')
                },
                google_plus: {enabled: false},
                pinterest: {enabled: false}
              }
            };
            window.shareBtn = new Share('#' + elem.parents('.media-card').attr('id') + ' .media-card-social-btn', shareConfig);

            // Facebook Like button
            window.fbLikeBtn = elem.find('.media-card-fb-like').addClass('fb-like')

            // Close header
            $('#header-learn').removeClass('opened');
            
            // don't allow to scroll
            window.noScroll();
          };
        })(bttn),
        onAfterOpen : function() {
          // can scroll again
          // window.canScroll();

            window.FB.XFBML.parse();
        },
        onBeforeClose : (function(btn) {

          return function(){
            var video = $(btn).find('.media-card-tile-image video');

            if(video.length){
              video.attr('src', 'javascript:void(0)');
            }
            // don't allow to scroll
            window.noScroll();
          };
        })(bttn),
        onAfterClose : function() {
          // can scroll again
          window.canScroll();
        }
      } );
    } );
  }
  window.addSubMorphs(document.querySelectorAll( '.morph-button' ));

})();  