/* Place all the behaviors and hooks related to the matching controller here.
* All this logic will automatically be available in application.js.
* You can use CoffeeScript in this file: http://coffeescript.org/
*/
$(document).on('ready page:load', function() {

    $("#project-tags").tagit({
    	fieldName: 'project[tag_list]',
    	singleField: true,
    	availableTags: gon.available_tags
    });

	if(gon.project_tags != null) {
		for(var i = 0; i < gon.project_tags.length; i++) {
			$('#project-tags').tagit("createTag", gon.project_tags[i]);
		}
	}

});