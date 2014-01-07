# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#jQuery ->
#	refrow = (title, author, lang, snippet, url, year) ->
#		r = '<tr><td>' + title + '</td><td>' 
#		r += author + '</td><td>'
#		r += lang + '</td><td>'
#		r += snippet + '</td><td>'
#		r += '<a class="refurl" href="' + url + '">External</a></td><td>'
#		r += year + '</td><td>'
#		r += $('#add-ref-link').html()
#		r += '</td></tr>'
#		return r
#
#	refCount = 0;
#
#	reBind = ->
#		$('.add-reference').on 'click', (event) =>
#			event.preventDefault()
#			u = $(event.target).parent().parent().find('.refurl').attr 'href'
#			i = $('<input value="' + u + '" type="text" name="topic[references_attributes][' + refCount + '][url]" /><br />')
#			refCount++
#			$('#reference-list').append(i)
#
#	#in the future? http://stackoverflow.com/questions/4220126/run-javascript-function-when-user-finishes-typing-instead-of-on-key-up
#	$('#reference-search').keyup =>
#		$.get ('/references/search/' + $('#reference-search').val() + '.json'), (data) =>
#			$('#reference-table').html("")
#			@data = data
#			t = $('<tbody id="reference-table">')
#			for ref in data 
#				t.append(refrow(ref.title, ref.author, ref.lang, ref.snippet, ref.url, ref.year))
#			
#			$('#reference-table').replaceWith(t)
#			
#			reBind()
#	