# global beforeEach, describe, it, assert, expect
"use strict"

describe 'TodoList Collection', ->
  beforeEach ->
    @TodoListCollection = new BackboneTodo.Collections.TodoList()
