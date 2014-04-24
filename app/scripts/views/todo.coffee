class BackboneTodo.Views.Todo extends Backbone.View

  template: JST['app/scripts/templates/todo.ejs']

  tagName: 'li'

  id: ''

  className: ''

  events:
    'click .toggle'   : 'toggleDone'
    'dblclick .view'  : 'edit'
    'click a.destroy' : 'clear'
    'keypress .edit'  : 'updateOnEnter'
    'blur .edit'      : 'close'

  initialize: () ->
    @listenTo @model, 'change', @render
    @listenTo @model, 'destroy', @remove
    return

  render: () ->
    @$el.html @template(@model.toJSON())
    @$el.toggleClass 'done', @get 'done'
    @input = @$ '.edit'
    @

  edit: ->
    @$el.addClass 'editing'
    @input.focus()
    return

  close: ->
    value = @input.val()
    if !value
      @clear()
    else
      @model.save title: value
      @$el.removeClass 'editing'
    return

  updateOnEnter: (e) ->
    close() if e.keyCode is 13
    return

  clear: ->
    @model.destroy()
    return