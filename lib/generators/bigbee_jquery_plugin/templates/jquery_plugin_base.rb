(($, window) ->
  "use strict"

  #=================================================================================
  # Define the plugin class
  #=================================================================================
  class <%= plugin_class_name %>
    
    constructor: (el, options) ->
      console.log "<%= plugin_class_name %>.constructor()"
      @$el = $(el)
      switch options.constructor
        when Array
          @options = @$el.data()
          this[options[0]](options[1])
        when String
          @[options]()
        when Object
          if @defaults
            @options = $.extend({}, @defaults, options)
          else
            @options = $.extend({}, options)
            
          @$el.data(@options)

    #-----------------------------------------------------------------------------
    # Additional plugin methods go here
    #-----------------------------------------------------------------------------

  #=================================================================================
  # Define the plugin
  #=================================================================================
  $.fn.extend <%= plugin_function_name %>: (options, args...) ->
    @each ->
      if options == 'option'
        new <%= plugin_class_name %>(this, args)
      else
        new <%= plugin_class_name %>(this, options || {})

) window.jQuery, window

