require './stylesheets/_themes/lib/functions.rb'
require 'zurb-foundation'

Awestruct::Extensions::Pipeline.new do
  development = Engine.instance.site.profile == 'development'

  helper Awestruct::Extensions::Partial
  helper Awestruct::Extensions::GoogleAnalytics

  extension Awestruct::Extensions::Posts.new '/posts'
  extension Awestruct::Extensions::Paginator.new :posts, '/index', :page_name => 'posts/page/', :per_page => 5
  unless development
    extension Awestruct::Extensions::Tagger.new :posts, '/index', 'posts/tag', :per_page => 5
  end
  # Indexifier *must* come before Atomizer
  extension Awestruct::Extensions::Indexifier.new
  unless development
    extension Awestruct::Extensions::Atomizer.new :posts, '/feed.xml', :num_entries => 10
  end
  extension Awestruct::Extensions::Disqus.new
end
