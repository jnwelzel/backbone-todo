Workspace = Backbone.Router.extend
  routes:
    '*filter': 'setFilter'

  setFilter: (param) ->
    if param
      param = param.trim()
    app.TodoFilter = param or ''
    # Trigger a collection filter event, causing hiding/unhiding
    # of Todo view items
    app.Todos.trigger('filter');
    return

@app.TodoRouter = new Workspace()
Backbone.history.start()