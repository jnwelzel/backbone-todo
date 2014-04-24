# global beforeEach, describe, it, assert, expect
"use strict"

describe 'Todo Model', ->
  beforeEach ->
    @TodoModel = new BackboneTodo.Models.Todo();
