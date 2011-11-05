(function() {
  global.HTMLSchema = {
    get: function(type, attribute) {
      var key, microdata, microformat, value;
      microdata = this.getMicrodata(type, attribute);
      microformat = this.getMicroformat(type, attribute);
      for (key in microformat) {
        value = microformat[key];
        microdata[key] = value;
      }
      return microdata;
    },
    getMicrodata: function(type, attribute) {
      var microdata;
      microdata = this.clone(HTMLSchema.Microdata[type]);
      if (attribute) {
        microdata = microdata.attributes[attribute];
      } else {
        delete microdata.attributes;
      }
      return microdata;
    },
    getMicroformat: function(type, attribute) {
      var microformat;
      microformat = this.clone(HTMLSchema.Microformat[type]);
      if (attribute) {
        microformat = microformat.attributes[attribute];
      } else {
        delete microformat.attributes;
      }
      return microformat;
    },
    clone: function(object) {
      var key, result, value;
      result = {};
      if (object) {
        for (key in object) {
          value = object[key];
          if (typeof value === "object") {
            result[key] = this.clone(value);
          } else {
            result[key] = value;
          }
        }
      }
      return result;
    },
    _getMicrodata: function(type, object) {
      var attributes, key, parent, value;
      object = this.clone(object);
      if (object["extends"]) {
        parent = this._getMicrodata(object["extends"], HTMLSchema.Microdata[object["extends"]]);
        attributes = parent.attributes;
        delete object["extends"];
        for (key in attributes) {
          value = attributes[key];
          object.attributes[key] = value;
        }
      }
      return object;
    },
    _getMicroformat: function(type, object) {
      var attributes, key, parent, value;
      object = this.clone(object);
      if (object["extends"]) {
        parent = this._getMicroformat(object["extends"], HTMLSchema.Microformat[object["extends"]]);
        attributes = parent.attributes;
        delete object["extends"];
        for (key in attributes) {
          value = attributes[key];
          object.attributes[key] = value;
        }
      }
      return object;
    },
    cache: function() {
      var a, attribute, attributes, b, key, object, type, value, _ref, _ref2;
      if (this._cached) {
        return this;
      }
      _ref = HTMLSchema.Microdata;
      for (type in _ref) {
        object = _ref[type];
        object = this._getMicrodata(type, object);
        attributes = object.attributes;
        delete object.attributes;
        this[type] = {};
        this[type].id = object;
        for (attribute in attributes) {
          value = attributes[attribute];
          this[type][attribute] = value;
        }
      }
      _ref2 = HTMLSchema.Microformat;
      for (type in _ref2) {
        object = _ref2[type];
        object = this._getMicroformat(type, object);
        attributes = object.attributes;
        delete object.attributes;
        this[type] || (this[type] = {});
        if (this[type].id) {
          for (key in object) {
            value = object[key];
            this[type].id[key] = value;
          }
        } else {
          this[type].id = object;
        }
        for (attribute in attributes) {
          value = attributes[attribute];
          if (this[type][attribute]) {
            for (a in value) {
              b = value[a];
              this[type][attribute][a] = b;
            }
          } else {
            this[type][attribute] = value;
          }
        }
      }
      this._cached = true;
      return this;
    },
    compile: function() {
      var result, type, types, _i, _len;
      types = Array.prototype.slice.call(arguments, 0, arguments.length);
      result = {};
      for (_i = 0, _len = types.length; _i < _len; _i++) {
        type = types[_i];
        result[type] = this[type];
      }
      return result;
    }
  };
  require('./html-schema/microformat');
  require('./html-schema/microdata');
  HTMLSchema.cache();
  module.exports = HTMLSchema;
}).call(this);
