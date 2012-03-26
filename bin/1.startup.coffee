(function() {
  var basePath, loadHaml, loadScript;

  loadScript = function(url, callback) {
    var js;
    js = document.createElement("script");
    js.type = "text/javascript";
    js.src = url;
    js.onload = callback;
    js.onreadystatechange = function() {
      if (this.readyState === "complete") return callback();
    };
    return document.getElementsByTagName('head')[0].appendChild(js);
  };

  loadHaml = function(options, callback) {
    var js;
    js = document.createElement("script");
    js.type = "text/javascript";
    js.src = options.src;
    js.id = options.id;
    js.onload = callback;
    js.onreadystatechange = function() {
      if (this.readyState === "complete") return callback();
    };
    return document.getElementsByTagName('head')[0].appendChild(js);
  };

  basePath = "http://dl.dropbox.com/u/1283975/iol-humanizer";

  loadScript("" + basePath + "/libs/head.load.min.js", function() {
    return head.js("" + basePath + "/libs/jquery.js", "" + basePath + "/libs/haml.js", "" + basePath + "/libs/underscore.js", "" + basePath + "/libs/json2.js", "" + basePath + "/libs/backbone.js", "" + basePath + "/libs/encoder.js", "" + basePath + "/bootstrap/js/bootstrap.js", "" + basePath + "/views/index.haml.js", "" + basePath + "/views/subjects.haml.js", "" + basePath + "/views/myprofile.haml.js", "" + basePath + "/views/datalist.haml.js", function() {
      var rendered;
      rendered = window.indexView({
        path: basePath
      });
      document.write(rendered);
      return $("html").hide();
    });
  });

}).call(this);
