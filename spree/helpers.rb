module Spree
  module Helpers
    def guide(name, url, options = {}, &block)
      link = content_tag(:a, :href => url) { name }
      result = content_tag(:dt, link)

      if ticket = options[:ticket]
        result << content_tag(:dd, lh(ticket), :class => 'ticket')
      end

      result << content_tag(:dd, capture(&block))
      concat(result)
    end

    def author(name, nick, image = 'credits_pic_blank.gif', &block)
      image = "images/#{image}"

      result = content_tag(:img, nil, :src => image, :class => 'left pic', :alt => name)
      result << content_tag(:h3, name)
      result << content_tag(:p, capture(&block))
      concat content_tag(:div, result, :class => 'clearfix', :id => nick)
    end

    def code(&block)
      c = capture(&block)
      content_tag(:code, c)
    end

    def diagram(name)
      link_to('<img src="files/diagrams/thumbnails/'+name+'.png" alt="'+name.humanize+'" />', "files/diagrams/png/#{name}.png") + 
        '<div style="text-align: center; font-size: 0.8em;">Click diagram to enlarge.'+
          '&nbsp;&nbsp;You can also download it as <a href="files/diagrams/dot/'+name+'.dot">.dot file</a> or'+
          '<a href="files/diagrams/svg/'+name+'.svg">.svg file</a>.</div>'
    end
  end
end
