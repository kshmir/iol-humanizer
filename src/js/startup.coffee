window.IOL = {} unless window.IOL

IOL = window.IOL

IOL.isOn = ()->
  $.jStorage.get("iol4humans-isOn")

IOL.setOn = ()->
  $.jStorage.set("iol4humans-isOn", true)

IOL.setOff = ()->
  $.jStorage.set("iol4humans-isOn", null)

IOL.setOnAndStart = ()->
  IOL.setOn()
  IOL.start()

IOL.reload = ()->
  IOL.setOff();
  window.location.reload()

IOL.start = ()->
  rendered = window.indexView {path: IOL.basePath}
  document.write rendered
  $("html").hide()
  loader = ()->
    window.IOL.loaded()
  setTimeout loader, 1000

IOL.loadTurnOnButton = ()->
  $("""
    <a href='javascript:window.IOL.start();' 
    class='js-iol-load' style='color:white'>
    Cargar IOL para Humanos</a><span> / <span>
    """).insertBefore("#infoAlumno a:last")
  $("""
    <a href='javascript:window.IOL.setOnAndStart();' 
    class='js-iol-load' style='color:white'>
    Activar siempre IOL para Humanos</a><span> / <span>
    """).insertBefore("#infoAlumno a:last")

IOL.basePath = window.baseLocation

unless IOL.isLoaded
  head.js "#{IOL.basePath}/views/index.haml.js",
          "#{IOL.basePath}/views/subjects.haml.js",
          "#{IOL.basePath}/views/myprofile.haml.js",
          "#{IOL.basePath}/views/datalist.haml.js", ()->
            if IOL.isOn()
              IOL.start()
            else
              IOL.loadTurnOnButton()

      
else 
  alert "IOL-Humanizer ya está cargado!"
  
