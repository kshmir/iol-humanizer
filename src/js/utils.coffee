window.IOL = {} unless window.IOL
window.IOL.Utils = {}

IOL = window.IOL


IOL.Utils.load = ()->
  # Collapse for menues 
  # TODO: Use bootstrap's native support
  $("body").on "click", ".collapser", (e)->
    $item = $(this)
    $target = $($item.attr("href"))
    e.preventDefault()
    $target.toggleClass("hidden")
    