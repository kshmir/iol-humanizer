window.IOL = {} unless window.IOL

window.IOL.loaded = ()->
  $("html").fadeIn 500
  IOL.Utils.load()
  IOL.Subjects.News.load()
  IOL.Subjects.Files.load()
  IOL.Subjects.load()
  IOL.Profile.load()
  IOL.baseRouting()
  IOL.isLoaded = true