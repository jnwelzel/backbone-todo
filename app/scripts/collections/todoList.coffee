class BackboneTodo.Collections.TodoList extends Backbone.Collection

  model: BackboneTodo.Models.Todo

  localStorage: new Backbone.LocalStorage('backbone-todos')

  done: ->
    @where {completed: true}
    return

  remaining: ->
    @where {completed: false}
    return

  nextOrder: ->
    if !@length
      return 1
    return @last().get('order') + 1

  comparator: 'order'