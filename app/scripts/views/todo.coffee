@app.TodoView = Backbone.View.extend

  template: JST['app/scripts/templates/todo.ejs']

  tagName: 'li'

  className: 'col-md-12'

  events:
    'click .toggle'   : 'toggleCompleted'
    'dblclick .view'  : 'edit'
    'click a.destroy' : 'clear'
    'keypress .edit'  : 'updateOnEnter'
    'blur .edit'      : 'close'

  initialize: ->
    @listenTo @model, 'change', @render
    @listenTo @model, 'destroy', @remove
    @listenTo @model, 'visible', @toggleVisible
    return

  render: ->
    @$el.html @template(@model.toJSON())
    @$el.toggleClass 'completed', @model.get('completed')
    @toggleVisible()
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

  # Toggles visibility of item
  toggleVisible: ->
    @$el.toggleClass 'hidden',  @isHidden()

  # Determines if item should be hidden
  isHidden: ->
    isCompleted = @model.get('completed')
    # hidden cases only
    ((not isCompleted and app.TodoFilter is 'completed') or (isCompleted and app.TodoFilter is 'active'))

  # Toggle the `"completed"` state of the model.
  toggleCompleted: ->
    @model.toggle()
