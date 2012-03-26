IOL.Subjects.Files = {}

IOL.Subjects.Files.load = ()->
  IOL.Subjects.Files.Collection = Backbone.Collection.extend 
    url: "http://iol2.itba.edu.ar/Paginas/MaterialDidactico.aspx?View=AllItems"

    parse: (rawResponse, subject)-> 
      subject_id = subject.id
      returner = $(rawResponse).find("#contenido table tr td a[onclick*=javascript]")

      returner = _.filter returner, (item)-> 
        $(item).attr("onclick").match subject_id
      returner = _.map returner, (item)->
        $item = $(item)
        matcher = $item.attr("onclick").match(/.*\(\'(.*)\'\).*/)
        file_url = matcher[1]
        name = $item.text()
        id = name
        new Backbone.Model {id: id, file_url: file_url, name : name }

      this.models = returner
      this.length = this.models.length
      returner
    fetch: (options)->
      self = this
      $.ajax
        url: self.url
        success: (data)-> options.success(self.parse(data, options.subject), data)
        error: (data)-> options.error(data)

  