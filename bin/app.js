(function() {
  var IOL;

  if (!window.IOL) window.IOL = {};

  window.IOL.Utils = {};

  IOL = window.IOL;

  IOL.Utils.load = function() {
    return $("body").on("click", ".collapser", function(e) {
      var $item, $target;
      $item = $(this);
      $target = $($item.attr("href"));
      e.preventDefault();
      return $target.toggleClass("hidden");
    });
  };

}).call(this);
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
(function() {

  if (!window.IOL) window.IOL = {};

  IOL.loaded = function() {
    $("html").fadeIn(500);
    IOL.Utils.load();
    IOL.Subjects.load();
    IOL.Subjects.News.load();
    IOL.Subjects.Files.load();
    IOL.Profile.load();
    return IOL.baseRouting();
  };

}).call(this);
(function() {

  IOL.Subjects = {};

  IOL.Subjects.load = function() {
    IOL.Subjects.View = Backbone.View.extend({
      tagName: "div",
      className: "subjectView",
      render: function() {
        var self;
        self = this;
        this.$el.find(".accordion-toggle").on("click", function(item) {
          return this.$el.find("#" + ($(item).attr("href"))).toggleClass("collapse");
        });
        this.$el.addClass("loading");
        this.$el.addClass("span8");
        return IOL.Subjects.items.fetch({
          success: function(collection, response) {
            if (console) console.log(collection);
            self.$el.removeClass("loading");
            self.$el.html(window.subjectsView({
              subjects: collection
            }));
            $(".subjectView").replaceWith(self.$el);
            self.loadFiles();
            return self.loadNews();
          }
        });
      },
      loadFiles: function() {
        var self;
        self = this;
        return _.each(IOL.Subjects.items.models, function(item) {
          var col;
          col = new IOL.Subjects.Files.Collection();
          return col.fetch({
            success: function(collection, response) {
              var collectionUrls, rendered;
              item.set("files", collection);
              collectionUrls = _.map(collection, function(file) {
                return {
                  href: file.get("file_url"),
                  text: file.get("name")
                };
              });
              rendered = window.datalistView({
                items: collectionUrls
              });
              return $(".subjectData[data-subjectid=\"" + item.id + "\"] .filesList").html(rendered).removeClass("loading");
            },
            subject: item
          });
        });
      },
      loadNews: function() {
        var self;
        self = this;
        return _.each(IOL.Subjects.items.models, function(item) {
          var col;
          col = new IOL.Subjects.News.Collection();
          return col.fetch({
            success: function(collection, response) {
              var collectionUrls, rendered;
              item.set("news", collection);
              collectionUrls = _.map(collection, function(news) {
                return {
                  href: "#/subjects/" + item.id + "/news/" + news.id + "/",
                  text: news.get("title"),
                  target: "_self"
                };
              });
              rendered = window.datalistView({
                items: collectionUrls
              });
              return $(".subjectData[data-subjectid=\"" + item.id + "\"] .newsList").html(rendered).removeClass("loading");
            },
            subject: item
          });
        });
      }
    });
    IOL.Subjects.Model = Backbone.Model;
    IOL.Subjects.Collection = Backbone.Collection.extend({
      model: IOL.Subjects.Model,
      url: window.location.toString(),
      parse: function(rawResponse) {
        var returner;
        returner = $(rawResponse).find(".zz1_QuickLaunchMenuMaterias0_8");
        returner = _.filter(returner, function(item) {
          return $(item).attr("href").match(/grado/);
        });
        returner = _.map(returner, function(item) {
          var $item, escapedId, id, name;
          $item = $(item);
          id = $item.attr("href").replace(/\/grado\//, "");
          escapedId = id.replace(/\./, "");
          name = $item.text();
          return new IOL.Subjects.Model({
            id: id,
            name: name,
            escapedId: escapedId,
            files: []
          });
        });
        this.models = returner;
        this.length = this.models.length;
        return returner;
      },
      fetch: function(options) {
        var self;
        self = this;
        return $.ajax({
          url: self.url,
          success: function(data) {
            return options.success(self.parse(data), data);
          },
          error: function(data) {
            return options.error(data);
          }
        });
      }
    });
    IOL.Subjects.items = new IOL.Subjects.Collection();
    IOL.Subjects.view = new IOL.Subjects.View();
    return IOL.Subjects.view.render();
  };

}).call(this);
(function() {

  IOL.Profile = {};

  IOL.Profile.load = function() {
    IOL.Profile.Router = Backbone.Router.extend({
      routes: {
        "/mi_analitico/": "mi_analitico",
        "/mis_docentes/": "mis_docentes",
        "/mis_companieros/": "mis_companieros"
      },
      mi_analitico: function() {},
      mis_docentes: function() {},
      mis_companieros: function() {}
    });
    IOL.Profile.View = Backbone.View.extend({
      tagName: "div",
      className: "profileView",
      render: function() {
        this.$el.addClass("span4");
        this.$el.html(window.myprofileView({}));
        return $(".profileView").replaceWith(this.$el);
      }
    });
    IOL.Profile.view = new IOL.Profile.View();
    return IOL.Profile.view.render();
  };

}).call(this);
(function() {

  IOL.Subjects.Files = {};

  IOL.Subjects.Files.load = function() {
    return IOL.Subjects.Files.Collection = Backbone.Collection.extend({
      url: "http://iol2.itba.edu.ar/Paginas/MaterialDidactico.aspx?View=AllItems",
      parse: function(rawResponse, subject) {
        var returner, subject_id;
        subject_id = subject.id;
        returner = $(rawResponse).find("#contenido table tr td a[onclick*=javascript]");
        returner = _.filter(returner, function(item) {
          return $(item).attr("onclick").match(subject_id);
        });
        returner = _.map(returner, function(item) {
          var $item, file_url, id, matcher, name;
          $item = $(item);
          matcher = $item.attr("onclick").match(/.*\(\'(.*)\'\).*/);
          file_url = matcher[1];
          name = $item.text();
          id = name;
          return new Backbone.Model({
            id: id,
            file_url: file_url,
            name: name
          });
        });
        this.models = returner;
        this.length = this.models.length;
        return returner;
      },
      fetch: function(options) {
        var self;
        self = this;
        return $.ajax({
          url: self.url,
          success: function(data) {
            return options.success(self.parse(data, options.subject), data);
          },
          error: function(data) {
            return options.error(data);
          }
        });
      }
    });
  };

}).call(this);
(function() {

  IOL.Subjects.News = {};

  IOL.Subjects.News.load = function() {
    IOL.Subjects.News.Router = Backbone.Router.extend({
      routes: {
        "/subjects/:subject_id/news/:news_id/": "show"
      },
      show: function(subject_id, news_id) {
        var news, news_, subject, subjects;
        subjects = IOL.Subjects.items.models;
        subject = _.find(subjects, function(subj) {
          return subj.id === subject_id;
        });
        news_ = subject.get("news");
        news = _.find(news_, function(n) {
          return news_id === n.id;
        });
        return alert(news.get("content"));
      }
    });
    IOL.Subjects.News.Collection = Backbone.Collection.extend({
      url: function(subject) {
        return "http://iol2.itba.edu.ar/grado/" + subject.id + "/Lists/Noticias_n/VistaNoticias.aspx";
      },
      parse: function(rawResponse, subject) {
        var returner, subject_id;
        subject_id = subject.id;
        returner = $(rawResponse).find("#contenido table tr td a[onclick*=GoToLink]");
        returner = _.map(returner, function(item) {
          var $item, content, id, matcher, title;
          $item = $(item);
          matcher = $item.attr("href").match(/ID=([0-9]+)/);
          id = matcher[1];
          title = $item.text();
          content = $item.parents(".ms-vb-title:first").next().html();
          return new Backbone.Model({
            id: id,
            title: title,
            content: content
          });
        });
        this.models = returner;
        this.length = this.models.length;
        return returner;
      },
      fetch: function(options) {
        var self;
        self = this;
        return $.ajax({
          url: self.url(options.subject),
          success: function(data) {
            return options.success(self.parse(data, options.subject), data);
          },
          error: function(data) {
            return options.error(data);
          }
        });
      }
    });
    return new IOL.Subjects.News.Router();
  };

}).call(this);
(function() {

  if (!!window.IOL) window.IOL = window.IOL;

  IOL.baseRouting = function() {
    new IOL.Profile.Router();
    return Backbone.history.start();
  };

}).call(this);
