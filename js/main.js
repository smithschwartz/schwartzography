$(function() {
  activeSlide = function() { return $(".carousel li.rslides1_on"); };
  slideLink = function() { return $(".carousel aside h2 a"); }

  setSlideLink = function() {
    link = slideLink();
    link.html(activeSlide().data("postTitle"));
    link.prop("href", activeSlide().data("postUrl"));
  };

  $(".rslides").responsiveSlides({
    auto: true,             // Boolean: Animate automatically, true or false
    speed: 500,            // Integer: Speed of the transition, in milliseconds
    timeout: 4000,          // Integer: Time between slide transitions, in milliseconds
    pager: false,
    after: setSlideLink
  });
});
