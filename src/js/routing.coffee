window.IOL = window.IOL unless window.IOL

IOL.baseRouting = ()->
  new IOL.Profile.Router()
  Backbone.history.start() 
