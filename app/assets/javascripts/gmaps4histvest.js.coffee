Gmaps4HistVest = {}

window.Gmaps4HistVest = Gmaps4HistVest

class @Gmaps4HistVest

    initialize: ->
        @my_mapOptions = {
            zoom: 11,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        }
        @my_map = new google.maps.Map(document.getElementById('map'), @my_mapOptions);
        @visible_infowindow = null
        @bounds_object = new google.maps.LatLngBounds()
        @marker_clusterer = null
        @touch_version = false
        
        # action when clicking on marker content
        $(document).on('click', '.infowindow .marker-topic[data-url]', ->
            window.location = $(this).data('url') unless $('body').hasClass('touch')
        )

    extend_bounds_with_objects: (objects) ->
        for obj in objects
            @bounds_object.extend(obj.google_marker.position)

    set_center: (lat_lng) ->
        @my_map.setCenter(lat_lng)

    set_zoom: (zoom) ->
        @my_map.setZoom(zoom)

    adjust_to_bounds: ->
        @extend_bounds_with_objects(@markers)       
        @set_center(@bounds_object.getCenter())
        @my_map.fitBounds(@bounds_object)        


    adjust_to_bounds_of_related_locations: ->
        related_locations = []
        for marker in @markers
            related_locations.push marker if marker.belongs_to_current_topic
        if related_locations.length > 0
            @extend_bounds_with_objects(related_locations)
        else
            @extend_bounds_with_objects(@markers)
        @set_center(@bounds_object.getCenter())
        @my_map.fitBounds(@bounds_object)

    bind_fancybox: ->
        _this = this;
        $(document).on('click', '.infowindow .marker-topic[data-url]', ->
            $(this).find('.infowindow-readmore').trigger 'click'
        )
        $(".infowindow-readmore").click (e)->                       
            _this.visible_infowindow.close() if _this.visible_infowindow
            e.preventDefault()
            $.fancybox.showActivity()            
            $.fancybox
                'href'            : $(this).attr('href')
                'padding'         : 0,
                'margin'          : 0,
                'width'           : 725,
                'height'          : '90%',
                'scroll'          : 'no',
                'autoScale'       : true,
                'autoDimensions'  : false,
                'transitionIn'    : 'none', 
                'transitionOut'   : 'none',
                'type'            : 'ajax',                
                'onCancel'        : ->
                    $.fancybox.hideActivity()
                'onComplete'      : ->
                    $.fancybox.hideActivity()
                    addthis.toolbox('.addthis_toolbox')
                    addthis.counter(".addthis_counter")
                    DISQUS.reset
                        reload: true                        

    open_infowindow: (current_map, infowindow, marker) ->
        return ->
            current_map.visible_infowindow.close() if current_map.visible_infowindow != null
            infowindow.open(current_map.my_map, marker)
            current_map.bind_fancybox() if current_map.touch_version
            current_map.visible_infowindow = infowindow            

    create_preview_infowindow: (marker, eventtype) ->
        marker.infowindow = new google.maps.InfoWindow({content: marker.description, maxWidth: 320})
        current_map = this
        google.maps.event.addListener(marker.google_marker, eventtype, @open_infowindow(current_map, marker.infowindow, marker.google_marker))

    create_marker: (marker)->
        return new google.maps.Marker
            position: new google.maps.LatLng(marker.lat, marker.lng)
            map: @my_map
            icon: marker.picture

    create_markers: (eventtype) ->
        for marker, index in @markers
            if not @markers[index].google_marker?
                @markers[index].google_marker = @create_marker marker
                @create_preview_infowindow(@markers[index], eventtype)

    clusterize: ->
        @marker_clusterer.clearMarkers() if @marker_clusterer != null

        markers_array = new Array

        for marker in @markers
            markers_array.push(marker.google_marker)

        @marker_clusterer = @create_clusterer(markers_array)

    create_clusterer: (markers_array) ->
        return new MarkerClusterer(@my_map, markers_array, { maxZoom: 11, gridSize: 50, styles: false })