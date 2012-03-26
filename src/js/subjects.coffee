window.IOL = {} unless window.IOL
IOL = window.IOL

IOL.Subjects = {} unless IOL.Subjects

IOL.Subjects.load = ()->

  # View Implementation
  IOL.Subjects.View = Backbone.View.extend
    tagName: "div"
    className: "subjectView"
    render: ()->
      self = this
      this.$el.find(".accordion-toggle").on "click", (item)->
        this.$el.find("##{$(item).attr("href")}").toggleClass("collapse")
      this.$el.addClass "loading"
      this.$el.addClass "span8"
      IOL.Subjects.items.fetch 
        success: (collection, response)->
          console.log collection if console
          self.$el.removeClass "loading"
          self.$el.html(window.subjectsView({subjects: collection}))
          $(".subjectView").replaceWith self.$el
          self.loadFiles()
          self.loadNews()

    loadFiles: ()->
      self = this
      _.each IOL.Subjects.items.models, (item)->
        col = new IOL.Subjects.Files.Collection()
        col.fetch
          success: (collection, response)->
            item.set "files", collection
            collectionUrls = _.map collection, (file)->
              href: file.get "file_url"
              text: file.get "name"
            rendered = window.datalistView({items: collectionUrls})
            $(".subjectData[data-subjectid=\"#{item.id}\"] .filesList").html(rendered).removeClass "loading"
          subject: item
    loadNews: ()->
      self = this
      _.each IOL.Subjects.items.models, (item)->
        col = new IOL.Subjects.News.Collection()
        col.fetch
          success: (collection, response)->
            item.set "news", collection
            collectionUrls = _.map collection, (news)->
              href: "#/subjects/#{item.id}/news/#{news.id}/"
              text: news.get "title"
              target: "_self"
            rendered = window.datalistView({items: collectionUrls})
            $(".subjectData[data-subjectid=\"#{item.id}\"] .newsList").html(rendered).removeClass "loading"
          subject: item



  # Model Implementation

  IOL.Subjects.Model = Backbone.Model

  # Collection Implementation

  IOL.Subjects.Collection = Backbone.Collection.extend 
    model: IOL.Subjects.Model
    url: window.location.toString()
    parse: (rawResponse)-> 
      returner = $(rawResponse).find(".zz1_QuickLaunchMenuMaterias0_8")

      returner = _.filter returner, (item)-> 
        $(item).attr("href").match /grado/
      returner = _.map returner, (item)->
        $item = $(item)
        id = $item.attr("href").replace(/\/grado\//, "")
        escapedId = id.replace(/\./,"")
        name = $item.text()
        new IOL.Subjects.Model {id: id, name: name, escapedId : escapedId, files: []}

      this.models = returner
      this.length = this.models.length
      returner

    fetch: (options)->
      self = this
      $.ajax
        url: self.url
        success: (data)-> options.success(self.parse(data), data)
        error: (data)-> options.error(data)


  IOL.Subjects.items = new IOL.Subjects.Collection()

  IOL.Subjects.view = new IOL.Subjects.View()

  IOL.Subjects.view.render()
        
