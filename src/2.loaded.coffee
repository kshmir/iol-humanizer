window.IOL = {} unless window.IOL



IOL.loaded = ()->
  $("html").fadeIn 500
  IOL.Utils.load()
  IOL.Subjects.load()
  IOL.Subjects.News.load()
  IOL.Subjects.Files.load()
  IOL.Profile.load()
  IOL.baseRouting()
  