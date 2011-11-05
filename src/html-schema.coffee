global.HTMLSchema =
  get: (type, attribute) ->
    microdata   = @getMicrodata(type, attribute)
    microformat = @getMicroformat(type, attribute)
    
    for key, value of microformat
      microdata[key] = value
      
    microdata
    
  getMicrodata: (type, attribute) ->
    microdata = @clone(HTMLSchema.Microdata[type])
    if attribute
      microdata = microdata.attributes[attribute]
    else
      delete microdata.attributes
    microdata
    
  getMicroformat: (type, attribute) ->
    microformat = @clone(HTMLSchema.Microformat[type])
    if attribute
      microformat = microformat.attributes[attribute]
    else
      delete microformat.attributes
    microformat
    
  clone: (object) ->
    result = {}
    if object
      for key, value of object
        if typeof(value) == "object"
          result[key] = @clone(value)
        else
          result[key] = value
    result
    
  _getMicrodata: (type, object) ->  
    object        = @clone(object)
    if object.extends
      parent = @_getMicrodata(object.extends, HTMLSchema.Microdata[object.extends])
      attributes = parent.attributes
      delete object.extends
      for key, value of attributes
        object.attributes[key] = value
    object
  
  _getMicroformat: (type, object) ->  
    object        = @clone(object)
    if object.extends
      parent = @_getMicroformat(object.extends, HTMLSchema.Microformat[object.extends])
      attributes = parent.attributes
      delete object.extends
      for key, value of attributes
        object.attributes[key] = value
    object
    
  cache: ->
    return @ if @_cached
    
    for type, object of HTMLSchema.Microdata
      object      = @_getMicrodata(type, object)
      attributes  = object.attributes
      delete object.attributes
      
      @[type]     = {}
      @[type].id  = object
      
      for attribute, value of attributes
        @[type][attribute] = value
    
    for type, object of HTMLSchema.Microformat
      object      = @_getMicroformat(type, object)
      attributes  = object.attributes
      delete object.attributes
      
      @[type]     ||= {}
      if @[type].id
        for key, value of object
          @[type].id[key] = value
      else
        @[type].id = object
      
      for attribute, value of attributes
        if @[type][attribute]
          for a, b of value
            @[type][attribute][a] = b
        else
          @[type][attribute] = value
    
    @_cached = true
       
    @
  
  compile: ->
    types     = Array.prototype.slice.call(arguments, 0, arguments.length)
    result    = {}
    
    for type in types
      result[type] = @[type]
      
    result

require './html-schema/microformat'
require './html-schema/microdata'

HTMLSchema.cache()

module.exports = HTMLSchema