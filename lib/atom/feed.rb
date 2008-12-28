require 'rubygems'
require 'libxml'

module Atom
  class Feed 
    include LibXML

    # Container Elements
    #   The "atom:feed" Element
    #   The "atom:entry" Element
    #   The "atom:content" Element
    #     The "type" Attribute
    #     The "src" Attribute
    #     Processing Model
    #     Examples
    # Metadata Elements
    #   The "atom:author" Element
    #   The "atom:category" Element
    #     The "term" Attribute
    #     The "scheme" Attribute
    #     The "label" Attribute
    #   The "atom:contributor" Element
    #   The "atom:generator" Element
    #   The "atom:icon" Element
    #   The "atom:id" Element
    #     Comparing atom:id
    #   The "atom:link" Element
    #     The "href" Attribute
    #     The "rel" Attribute
    #     The "type" Attribute
    #     The "hreflang" Attribute
    #     The "title" Attribute
    #     The "length" Attribute
    #   The "atom:logo" Element
    #   The "atom:published" Element
    #    The "atom:rights" Element
    #    The "atom:source" Element
    #    The "atom:subtitle" Element
    #    The "atom:summary" Element
    #    The "atom:title" Element
    #    The "atom:updated" Element

    NAMESPACES =  %w[ atom:http://www.w3.org/2005/Atom ]  
    SIMPLE_ATOM_ELEMENTS = %w[ title subtitle updated generator author]
    COMPOUND_ATOM_ELEMENTS = {
      :links => {:xpath => "//atom:feed/atom:link"}
    }
    ALIASED_ATOM_ELEMENTS = {
      :atom_id => { :xpath => '//atom:feed/atom:id'},
      :author_name => {:xpath => '//atom:feed/atom:author/atom:name'},
      :author_email => {:xpath => '//atom:feed/atom:author/atom:email'},
    }

    attr_reader :document

    def self.file(file_name)
      self.new(XML::Parser.file(file_name).parse)
    end

    def initialize(document)
      @document = document

      define_elements(SIMPLE_ATOM_ELEMENTS)
      define_aliased_elements(ALIASED_ATOM_ELEMENTS)
      define_compound_elements(COMPOUND_ATOM_ELEMENTS)
    end

    def define_elements(element_set)
      element_set.each do |name|
        eval(%{
          def #{name}
            extract_content('//atom:feed/atom:#{name}')
          end
        })
      end
    end

    def define_compound_elements(element_set)
      element_set.each_key do |name|
        eval(%{
          def #{name.to_s}
            extract('#{element_set[name][:xpath]}')
          end
        })
      end
    end

    def define_aliased_elements(element_set)
      element_set.each_key do |name|
        eval(%{
          def #{name.to_s}
            extract_content('#{element_set[name][:xpath]}')
          end
        })
      end
    end  

    def value
      content
    end

    def value=(string)
      content = string
    end  

    def alternate_link
      extract("//atom:feed/atom:link[@rel='alternate']").first.attributes['href']
    end

    def feed_link
      extract("//atom:feed/atom:link[@rel='http://schemas.google.com/g/2005#feed']").first.attributes['href']    
    end

    def post_link
      extract("//atom:feed/atom:link[@rel='http://schemas.google.com/g/2005#post']").first.attributes['href']
    end

    def self_link
      extract("//atom:feed/atom:link[@rel='self']").first.attributes['href']
    end

    def author
      @author ||= Author.new(author_name,author_email)
    end

    def entries
      extract("//atom:feed/atom:entry")
    end

    def extract(xpath)
      xtract = @document.find(xpath, NAMESPACES) 
      (xtract.nil? or xtract.empty?) ? [XML::Node.new('')] : xtract
    end

    def extract_content(xpath)
      extract(xpath)[0].content.strip
    end

  end
  
end