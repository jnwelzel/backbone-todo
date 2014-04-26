class BackboneTodo.Collections.TodoList extends Backbone.Collection

  model: BackboneTodo.Models.Todo

  localStorage: new Backbone.LocalStorage('backbone-todos')

  completed: ->
    @where completed: true
    return

  remaining: ->
    @where completed: false
    return

  nextOrder: ->
    if !@length
      return 1
    return @last().get('order') + 1

  # Todos are sorted by their original insertion order.
  comparator: (todo) ->
    todo.get 'order'
