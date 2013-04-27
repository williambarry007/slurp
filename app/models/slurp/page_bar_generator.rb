
class Slurp::PageBarGenerator  
  #
  # Parameters:
  #
  #	params:	array of key/value pairs that must include the following:
  #
  #		base_url: 		url without querystring onto which the parameters 
  #						are added.
  #	
  #		itemCount:		Total number of items.
  #
  #	In addition, the following parameters are not required but may be 
  #	included in the array:
  #	
  #		itemsPerPage:	Number of items you want to show per page.
  #						Defaults to 10 if not present.
  #
  #		page:			Current page number.  Defaults to 0 if not present.
  #
  attr_accessor :params, :options
  
  def initialize(post_get, params = nil, options = nil)
    
    params  = {} if params.nil?
    options = {} if options.nil?
    
  	# Note: a few keys are required:
  	# base_url, page, itemCount, itemsPerPage
  	@params = {}
  	@options = {
  		'sort' 			      => '',
  		'desc' 			      => false,
  		'base_url'		    => '',
  		'page'			      => 0,
  		'item_count'		  => 0,
  		'items_per_page'  => 10
  	}      
  	params.each   { |key, val| @params[key]  = val }
  	options.each  { |key, val| @options[key] = val }
  	@params.each  { |key, val| @params[key]  = post_get[key].nil? ? val : post_get[key] }			
  	@options.each { |key, val| @options[key] = post_get[key].nil? ? val : post_get[key] } 
  	                      
  end
  
  def ok(val)
    return false if val.nil?
    return true  if val.is_a? Array
    return true  if val.is_a? Hash
    return true  if val.is_a? Integer
    return true  if val.is_a? Fixnum
    return true  if val.is_a? Float
    return true  if val.is_a? Bignum
    return true  if val.is_a? TrueClass
    return true  if val.is_a? FalseClass
    return false if val == ""
    return true
  end
  	
  def generate		
  	# Check for necessary parameter values
  	return false if !ok(@options['base_url']) # Error: base_url is required for the page bar generator to work.
  	return false if !ok(@options['item_count']) # Error: itemCount is required for the page bar generator to work.
  	
  	# Set default parameter values if not present
  	@options['items_per_page'] = 10  if @options["items_per_page"].nil?
  	@options['page']           = 0   if @options["page"].nil?		
  	
  	# Variables to make the search form work 
  	vars = get_vars()
  	page = @options["page"]
  			
  	# Max links to show (must be odd) 
  	total_links = 9
  					
  	prev_page = page - 1            
  	next_page = page + 1
  	
  	total_pages = @options['item_count'] / @options['items_per_page']
  	
  	if (total_pages < total_links)
  		start = 0
  		stop = total_pages			
  	else
  		start = page - (total_links/2).floor			
  		start = 0 if start < 0
  		stop = start + total_links
  		
  		if (stop > total_pages)
  			stop = total_pages				
  			start = stop - total_links
  			
  			start = 0 if start < 0
  		end
  	end
  	
  	base_url = @params['base_url']
  	str = ''
  	str += "<p>Results Pages: showing page " + (page+1).to_s + " of #{total_pages}</p>\n"
  	str += "<div class='page_links'>\n"
  	if (page > 0)
  	  str += "<a href='#{base_url}?#{vars}&page=#{prev_page}'>Previous</a>"
    end
  	str += "<div class='middle_links'>\n"
  	
  	for i in start..(stop-1)
  		if (page != i)
  		  str += "<a href='#{base_url}?#{vars}&page=#{i}'>" + (i+1) + "</a>"
  		else
  			str += "<span class='current_page'>" + (i+1) + "</span>"
  		end
  	end
  	str += "</div>\n"
  	
  	if (page < (total_pages-1))
  		str += "<a href='#{base_url}?#{vars}&page=#{next_page}'>Next</a>"
  	end
  	str += "</div>\n"
    
  	return str
  end
  
  def get_vars()  
    vars = []
    @params.each do |k,v|
      vars.push("#{k}=#{v}") if !v.nil? && v.length > 0 
    end
    return URI.escape(vars.join('&'))
  end
  
  def sortable_table_headings(cols)
    vars = get_vars()
  	str = ''
    
  	# key = sort field, value = text to display
  	cols.each do |sort, text|
  		desc  = @options['sort'] == sort ? (@options['desc'] ? 0 : 1) : 0
  		arrow = @options['sort'] == sort ? (@options['desc'] ? ' &uarr' : ' &darr') : ''					
  		link = @options['base_url'] + "?#{vars}&sort=#{sort}&desc=#{desc}"
  		str += "<th><a href='#{link}'>#{text}#{arrow}</a></th>\n"
  	end
  	return str  	
  end
  
  def where
    vars = {}
    @params.each do |k,v|
      vars[k] = v if !v.nil? && v.length > 0 
    end
    return vars
  end
  
  def limit
    return @options['items_per_page']
  end
  
  def offset
    return @options['page'] * @options['items_per_page']
  end
  
  def reorder
    if (!@options['sort'].nil? && @options['sort'].length > 0)
      return @options['sort']
    end
    return "id"
  end
end

