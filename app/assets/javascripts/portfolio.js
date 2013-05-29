rgb.portfolio = (function($) {

    var height;
    var width;
    var margin = 200;
    var delta = 0;

    var init = function() {
        $(document).ready(function() {
            setGallerySize();
            $(window).bind('resize', imgsize);
            $(".gallery img").lazyload({ effect: "fadeIn", threshold:2000});
            $('.gallery img').on('click', transition);
            initMousewheel();
        });
    };


    var setGallerySize = function() {
        height  = $(window).height();
        width = $(window).width();
        $(".gallery").height(height);
    };


    var imgsize = function(evt) {
        height  = $(window).height();
        totalImageWidth = 0;
        width = $(window).width();
        $(".gallery").height(height);
    };


    var transition = function(evt) {
        var img_id = parseInt($(this).data("photo-number"));
        var next = $(".gallery .photo-" + (img_id + 1));
        $('html, body').animate({
            scrollLeft: next.position().left - margin
        });
    };


    var initMousewheel = function() {
        $("html, body").bind("mousewheel", function(event, delta) {
            this.scrollLeft -= ((delta) * 50);
              event.preventDefault();
        });
    };

    return {
        'init' : init
    };

})(jQuery);
