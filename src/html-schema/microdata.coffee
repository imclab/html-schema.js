HTMLSchema.Microdata =
  object:
    itemtype:          "http://schema.org/Thing"
    attributes:        
      name:            
        itemprop:      "name"
      title:           
        itemprop:      "title"
      description:     
        itemprop:      "description"
      image:           
        itemprop:      "image"
      url:             
        itemprop:      "url"
  contact:             
    extends:           "object"
    itemtype:          "http://schema.org/Contact"
    attributes:        
      kind:            
        itemprop:      "contactType" # sales contact, PR, etc.
      email:           
        itemprop:      "email"
      fax:             
        itemprop:      "faxNumber"
      phone:           
        itemprop:      "telephone"
  address:             
    extends:           "contact"
    itemtype:          "http://schema.org/PostalAddress"
    attributes:        
      street:          
        itemprop:      "streetAddress"
      city:            
        itemprop:      "addressLocality"
      state:           
        itemprop:      "addressRegion"
      postalCode:     
        itemprop:      "postalCode"
      postOfficeBox: 
        itemprop:      "postOfficeBoxNumber"
      country:         
        itemprop:      "addressCountry"#, :type => :place, :source => :country

module.exports = HTMLSchema.Microdata