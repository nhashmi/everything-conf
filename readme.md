# An introduction to scraping data

## Learning objectives

1. Define 'scraping'.
2. Compare scraping to other methods of using data. Give an example of a good use case for scraping.
3. Name some libraries that can be used to facilitate scraping.


## What is scraping? Why would we ever want to use it?

Simply put, web scraping means fetching data from websites, usually so you can use the harvested information in some other form.

You might want to use web scraping when you can't use an API or download a formatted dataset. Web scraping techniques can be useful if you're making web applications, doing research, or just want to automate some mundane task.


## What are some examples of projects that have used data scraping?

- Dykstra, Dykstra, and Sandefur, ["We Just Ran Twenty-Three Million Queries of the World Bank's Website"](http://www.cgdev.org/sites/default/files/dykstra-sandefur-povcal-net-world-bank_2.pdf)

  Poverty researchers wanted access to a dataset that the World Bank claimed was public. Unfortunately, the interface the World Bank designed to access the data took a number of clicks and only returned results one country at a time. So they wrote a program that would fill out the forms, query the database, and save the results. They then released the data so that they were truly public.

- [overcast-time](https://github.com/nhashmi/overcast-time)

  I wrote this gem to allow users of the [Overcast podcast app](http://overcast.fm) to figure out how many hours of podcasts they had left. The app doesn't provide any way to do this, so I wrote a tool that logs you onto the online site, collects all the `<div>` elements on the page and parses them using regular expressions. The gem then returns to you the amount of time you have left across all your podcasts.

## Sounds good. Let's scrape something together.

### Useful gems

[Nokogiri](http://www.nokogiri.org/) allows you to parse HTML and XML.

[Mechanize](https://github.com/sparklemotion/mechanize) is a helpful gem that makes it easy to interact with web pages. You can click elements on the page and fill out forms easily. The pages returned respond to Nokogiri methods.

Let's try scraping the items on reddit's front page.

To get started, install the mechanize gem:

```rb
gem install mechanize
```

Now open up a new ruby file and include the following

```rb
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

```
