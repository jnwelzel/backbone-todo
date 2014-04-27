@app.TodoView = Backbone.View.extend

  template: JST['app/scripts/templates/todo.ejs']

  tagName: 'li'

  className: 'col-md-12'

  events:
    'click .toggle'   : 'toggleDone'
    'dblclick .view'  : 'edit'
    'click a.destroy' : 'clear'
    'keypress .edit'  : 'updateOnEnter'
    'blur .edit'      : 'close'

  initialize: ->
    @listenTo @model, 'change', @render
    @listenTo @model, 'destroy', @remove
    return

  render: ->
    @$el.html @template(@model.toJSON())
    @$input = @$ '.edit'
    @

  edit: ->
    @$el.addClass 'editing'
    @$input.focus()
    return

  close: ->
    value = @$input.val()
    if !value
      @clear()
    else
      @model.save title: value
      @$el.removeClass 'editing'
    return

  updateOnEnter: (e) ->
    close() if e.keyCode is app.ENTER_KEY
    return

  clear: ->
    @model.destroy()
    return