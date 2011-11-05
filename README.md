# HTMLSchema.js

## Install

### For Node

```
npm install html-schema
```

### For the Browser

``` html
<script type="text/javascript" src="/path/to/html-schema.js"></script>
```

## Usage

The main goal is to simplify adding semantic attributes to your markup.  So in HTML you might want this:

``` html
<cite class='author vcard' itemprop='author' itemtype='http://schema.org/Person'>
  <a href='/' class='url' rel='author' itemprop='url'>
    <figure>
      <img src='/' class='photo' itemprop='image'/>
      <figcaption class='fn'>Lance Pollard</figcaption>
    </figure>
  </a>
  <!-- ... -->
</cite>
```

That's a lot to remember.  If you're using a templating framework, say jQuery.tmpl, you can do something like this:

``` javascript

```

``` html
<script>
  var schema = {"author":{"id":{"class":"author vcard","itemprop":"author","itemtype":"http://schema.org/Person"}}} //... the rest of the json
  
  function attrs(attributes) {
    var result = [];
    var key;
    
    for (key in attributes)
      result.push(key + "='" + attributes[key] + "'")
      
    return result.join(" ")
  }
</script>

<script id='author-template' type='text/html'>
  <cite>
    <a href='/' ${attrs(schema.author.id)}>
      <figure>
        <img src='/' ${attrs(schema.author.image)}/>
        <figcaption ${attrs(schema.author.name)}>Lance Pollard</figcaption>
      </figure>
    </a>
    <!-- ... -->
  </cite>
</script>
```

You can compile out just the schema you are using for optimal performance:

``` coffeescript
HTMLSchema  = require 'html-schema'
fs          = require 'fs'

task 'html-schema', ->
  fs.writeFile 'html-schema.json', JSON.stringify HTMLSchema.compile("address", "contact")

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
```

You can also just use the library directly.

``` coffeescript
HTMLSchema.address.id #=> { itemtype : 'http://schema.org/PostalAddress', class : 'adr' }
```

## Real-World Usage



## Development

```
./node_modules/coffee-script/bin/coffee -o lib -w src
./node_modules/jasmine-node/bin/jasmine-node --coffee ./spec
```
