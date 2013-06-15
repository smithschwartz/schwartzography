def new_block?(line)
  line =~ /:/
end

def cat_block?(line)
  line =~ /\Acategories:/
end

def cat_from(line)
  line =~ /- (.*)/
  $1
end

def cats_from_file(filename)
  cats = []
  File.open(filename, "r") do |infile|
    while (line = infile.gets)
      if new_block?(line)
        if cat_block?(line)
          read_categories = true
          next
        elsif read_categories
          read_categories = false
        end
      end

      if read_categories
        cats << cat_from(line)
      end
    end
  end
  cats
end

def cats_from_directory(dirname)
  all_cats = []
  Dir.glob("_posts/*").each_with_object({}) do |filename, _|
    all_cats << cats_from_file(filename)
  end
  all_cats.flatten.compact.uniq
end

def category_filename!(category)
  name = category.gsub(/ /, '-').downcase
  dir = "category/#{name}/"
  Dir.mkdir(dir)
  "#{dir}/index.html"
end

def write_category_file(category)
  File.open(category_filename!(category), "w") do |outfile|
    outfile.write(category_template(category))
  end
end

def category_template(category)
%Q{---
layout: default
title: #{category}
carousel_text: Adventures in #{category}
---
{% for post in site.categories["#{category.downcase}"] %}
  {% include _truncated_post.html  %}
{% endfor %}
}
end

def clean_cat_dir
  `rm -rf category/*`
end

def write_cat_files(cats)
  cats.each do |cat|
    write_category_file(cat)
  end
end

def all_cats
  cats_from_directory("_posts")
end

clean_cat_dir
write_cat_files(all_cats)
