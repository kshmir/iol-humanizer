window.IOL = {} unless window.IOL
IOL = window.IOL

IOL.Subjects = {} unless IOL.Subjects

IOL.Subjects.News = {}

IOL.Subjects.News.load = ()->
    IOL.Subjects.News.Router = Backbone.Router.extend 
      routes:
        "/subjects/:subject_id/news/:news_id/" : "show"
      show: (subject_id, news_id) ->
        subjects = IOL.Subjects.items.models
        subject = _.find subjects, (subj)-> subj.id == subject_id
        news_ = subject.get "news"
        news = _.find news_, (n)-> news_id == n.id
        alert(news.get("content"));


    IOL.Subjects.News.Collection = Backbone.Collection.extend 
      url: (subject)-> "http://iol2.itba.edu.ar/grado/#{subject.id}/Lists/Noticias_n/VistaNoticias.aspx"

      parse: (rawResponse, subject)-> 
        subject_id = subject.id
        returner = $(rawResponse).find("#contenido table tr td a[onclick*=GoToLink]")

        returner = _.map returner, (item)->
          $item = $(item)
          matcher = $item.attr("href").match(/ID=([0-9]+)/)
          id = matcher[1]
          title = $item.text()
          content = $item.parents(".ms-vb-title:first").next().html()
          new Backbone.Model {id: id, title: title, content : content }

        this.models = returner
        this.length = this.models.length
        returner
      fetch: (options)->
        self = this
        $.ajax
          url: self.url(options.subject)
          success: (data)-> options.success(self.parse(data, options.subject), data)
          error: (data)-> options.error(data)

    new IOL.Subjects.News.Router()