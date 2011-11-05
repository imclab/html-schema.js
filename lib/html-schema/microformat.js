(function() {
  HTMLSchema.Microformat = {
    object: {
      attributes: {
        name: {
          itemprop: "name"
        },
        title: {
          itemprop: "title"
        },
        description: {
          itemprop: "description"
        },
        image: {
          itemprop: "image"
        },
        url: {
          itemprop: "url"
        }
      }
    },
    address: {
      "class": "adr",
      attributes: {
        street: {
          "class": "street-address"
        },
        suite: {
          "class": "extended-address"
        },
        city: {
          "class": "locality"
        },
        state: {
          "class": "region"
        },
        postalCode: {
          "class": "postal-code"
        },
        postOfficeBox: {
          "class": "post-office-box"
        },
        country: {
          "class": "country-name"
        }
      }
    }
  };
  module.exports = HTMLSchema.Microdata;
}).call(this);
