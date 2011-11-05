HTMLSchema  = require '../lib/html-schema'
Shift       = require 'shift'

describe "html-schema", ->
  describe 'microdata', ->
    it 'should have an object', ->
      expect(HTMLSchema.getMicrodata("object")).toEqual itemtype: "http://schema.org/Thing"
      expect(HTMLSchema.getMicrodata("object", "name")).toEqual itemprop: "name"
      
  it "should return html attributes", ->
    expect(HTMLSchema.address.city).toEqual { itemprop: 'addressLocality', class: 'locality' }
    
  describe "rendering", ->
    it 'should output a hash', ->
      expect(HTMLSchema.address.id).toEqual { itemtype : 'http://schema.org/PostalAddress', class : 'adr' }
      expect(HTMLSchema.address.name).toEqual { itemprop: 'name' }
      expect(HTMLSchema.address.city).toEqual { itemprop: 'addressLocality', class: 'locality' }
    
    it 'should render mustache', ->
      engine = new Shift.Mustache
      
      input   = "<span class='{{class}}' itemprop='{{itemprop}}'>San Diego</span>"
      output  = "<span class='locality' itemprop='addressLocality'>San Diego</span>"
      
      result = engine.render input, locals: HTMLSchema.get("address", "city")
      expect(result).toEqual output
      
      result = engine.render input, locals: HTMLSchema.address.city
      expect(result).toEqual output
  
  it 'should compile', ->
    expect(HTMLSchema.compile("address", "contact")).toEqual
      address:
        id:              { itemtype: 'http://schema.org/PostalAddress', class: 'adr' }
        street:          { itemprop: 'streetAddress', class: 'street-address' }
        city:            { itemprop: 'addressLocality', class: 'locality' }
        state:           { itemprop: 'addressRegion', class: 'region' }
        country:         { itemprop: 'addressCountry', class: 'country-name' }
        kind:            { itemprop: 'contactType' }
        email:           { itemprop: 'email' }
        fax:             { itemprop: 'faxNumber' }
        phone:           { itemprop: 'telephone' }
        name:            { itemprop: 'name' }
        title:           { itemprop: 'title' }
        description:     { itemprop: 'description' }
        image:           { itemprop: 'image' }
        url:             { itemprop: 'url' }
        suite:           { class: 'extended-address' }
        postalCode:      { itemprop: 'postalCode', class: 'postal-code' }
        postOfficeBox:   { itemprop: 'postOfficeBoxNumber', class: 'post-office-box' }
      contact:
        id:              { itemtype: 'http://schema.org/Contact' }
        kind:            { itemprop: 'contactType' }
        email:           { itemprop: 'email' }
        fax:             { itemprop: 'faxNumber' }
        phone:           { itemprop: 'telephone' }
        name:            { itemprop: 'name' }
        title:           { itemprop: 'title' }
        description:     { itemprop: 'description' }
        image:           { itemprop: 'image' }
        url:             { itemprop: 'url' }
    
    
  {{>Schema.address(street:'', email:'')}}