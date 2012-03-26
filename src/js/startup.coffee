window.IOL = {} unless window.IOL

loadHaml = (options, callback) ->
  js = document.createElement "script"
  js.type = "text/javascript"
  js.src = options.src
  js.id = options.id
  js.onload = callback
  js.onreadystatechange = ()->
    callback() if this.readyState == "complete"
  document.getElementsByTagName('head')[0].appendChild(js);

basePath = window.baseLocation

head.js "#{basePath}/views/index.haml.js",
        "#{basePath}/views/subjects.haml.js",
        "#{basePath}/views/myprofile.haml.js",
        "#{basePath}/views/datalist.haml.js", ()->
            rendered = window.indexView {path: basePath}
            document.write rendered
            $("html").hide()