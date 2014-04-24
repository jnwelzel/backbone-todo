# global beforeEach, describe, it, assert, expect
"use strict"

describe 'App View', ->
  beforeEach ->
    @AppView = new BackboneTodo.Views.App();
