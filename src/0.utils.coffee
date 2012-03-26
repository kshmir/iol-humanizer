window.IOL = {} unless window.IOL
window.IOL.Utils = {}

IOL = window.IOL

IOL.Utils.load = ()->
  $("body").on "click", ".collapser", (e)->
    $item = $(this)
    $target = $($item.attr("href"))
    e.preventDefault()
    $target.toggleClass("hidden")
    