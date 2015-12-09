#= require calculator
describe "Calculator", ->

  it "should add two numbers", ->
    calc = new Calculator()
    expect( calc.add(2, 2) ).to.be 4