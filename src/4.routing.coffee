window.IOL = window.IOL unless not window.IOL

IOL.baseRouting = ()->
  new IOL.Profile.Router()
  Backbone.history.start() 