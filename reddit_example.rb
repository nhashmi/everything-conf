require 'rubygems'
require 'mechanize'

# Create a new mechanize object
agent = Mechanize.new

# Have Mechanize fetch reddit.com and store it in a variable called 'page'
page = agent.get('http://reddit.com')

# The list of links on the page
site_table = page.search("div.sitetable")

# Uncomment to inspect the object returned by Mechanize
# p page

# Get all <a> elements with a class of 'title'
divs = site_table.search("div.thing")

# Only select <div> elements that have a rank
tops = divs.select { |div| div.search("span.rank") }

# Print out each link
tops.each do |post|
  top_link = post.search("a.title")
  puts top_link[0]
end
