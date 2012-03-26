IOL.Profile = {}

IOL.Profile.load = ()->
  # Router Implementation

  IOL.Profile.Router = Backbone.Router.extend
    routes:
      "/mi_analitico/" : "mi_analitico"
      "/mis_docentes/" : "mis_docentes"
      "/mis_companieros/" : "mis_companieros"
    mi_analitico: ()-> 
    mis_docentes: ()->   
    mis_companieros: ()-> 


  IOL.Profile.View = Backbone.View.extend
      tagName: "div"
      className: "profileView"
      render: ()->
        this.$el.addClass "span4"
        this.$el.html(window.myprofileView({}))
        $(".profileView").replaceWith this
        .$el

  IOL.Profile.view = new IOL.Profile.View()

  IOL.Profile.view.render()
