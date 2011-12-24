live_search = {

  init : function( target ) {
    jQuery( target ).bind( 'keyup', this.handle_event )
  },

  handle_event : function( event ) {
    query = jQuery(event.currentTarget).val();

    switch( event.which ) {
      case 13:
        break;
      default:
        live_search.get_results( query );
        break;
    }
  },

  get_results : function( query ) {
    var search_term = query;
    jQuery.ajax({
      url     : "/special_guests/search",
      data    : "search_term=" + query,
      success : function( response ) {
        jQuery('#search_results').html( response )
      }
    })
  }
}


live_admin_search = {

  init : function( target ) {
    jQuery( target ).bind( 'keyup', live_admin_search.handle_event )
  },

  handle_event : function( event ) {
    query = jQuery(event.currentTarget).val();

    switch( event.which ) {
      case 13:
        break;
      default:
        live_admin_search.get_results( query );
        break;
    }
  },

  get_results : function( query ) {
    var search_term = query;
    jQuery.ajax({
      url     : "/special_guests/admin_search",
      data    : "search_term=" + query,
      success : function( response ) {
        console.log( response )
        jQuery('#special_guests tbody').html( response )
      }
    })
  }
}