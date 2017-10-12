//jQuery to collapse the navbar on scroll
$(window).scroll(function() {

    if ($(".navbar").offset().top > 50) {
        $(".navbar-fixed-top").addClass("top-nav-collapse");
    } else {
        $(".navbar-fixed-top").removeClass("top-nav-collapse");
    }
});

//jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
    $(document).on('click', 'a.page-scroll', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 1500, 'easeInOutExpo');
        event.preventDefault();
    });
});

$(document).ready(function(){
  
  if($("#search_button")){
      $("#search_button").on('click',function(){
          var id = $("#id").val();
          var spiner =$("#spiner option:selected").val();
          
          window.location.href="http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/mapa.xquery?id="+id+"&spiner="+spiner+"";
      })
  }
  
});