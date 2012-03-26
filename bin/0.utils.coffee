(function() {
  var IOL;

  if (!window.IOL) window.IOL = {};

  window.IOL.Utils = {};

  IOL = window.IOL;

  IOL.Utils.load = function() {
    return $("body").on("click", ".collapser", function(e) {
      var $item, $target;
      $item = $(this);
      $target = $($item.attr("href"));
      e.preventDefault();
      return $target.toggleClass("hidden");
    });
  };

}).call(this);
