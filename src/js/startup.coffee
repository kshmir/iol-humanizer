window.IOL = {} unless window.IOL

IOL = window.IOL

IOL.basePath = window.baseLocation

unless IOL.isLoaded
  head.js "#{IOL.basePath}/views/index.haml.js",
          "#{IOL.basePath}/views/subjects.haml.js",
          "#{IOL.basePath}/views/myprofile.haml.js",
          "#{IOL.basePath}/views/datalist.haml.js", ()->
              rendered = window.indexView {path: IOL.basePath}
              document.write rendered
              $("html").hide()
              loader = ()->
                window.IOL.loaded()
              setTimeout loader, 1000
else 
  alert "IOL-Humanizer ya está cargado!"
  