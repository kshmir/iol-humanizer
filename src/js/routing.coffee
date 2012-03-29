window.IOL = window.IOL unless window.IOL

IOL = window.IOL

IOL.DefaultRouter =  Backbone.Router.extend
    routes: 
      "" : "index"
      "/" : "index"
    index: ()->
      $(".modal").modal("hide")

IOL.baseRouting = ()->

  new IOL.Profile.Router()  
  new IOL.DefaultRouter()

  Backbone.history.start()