post_md = ARGV[0]
permalink = `grep permalink #{post_md} | sed 's/permalink: //'`
url = "http://schwartzography.com/#{permalink}"
html = `curl #{url}`
html =~ /src="([^"]*).*alt="([^"]*)/
img = "featured_img: '#{$1}'"
alt = "featured_alt: '#{$2}'"

already_has_img = (`grep featured_img #{post_md}`.length > 0)

unless already_has_img
  p `sed -i.bak '/title/a \\
  #{img}\\
  #{alt}\\
  '  #{post_md}`
end
