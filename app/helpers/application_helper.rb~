module ApplicationHelper
  def all_locales
    {
      'en'=>'English',
      #'en-GB'=>'English (UK)',
      #'en-US'=>'English (US)',
      'zh-CN'=>'中文-中国',
      #'zh-HK'=>'中文(香港)',
      'zh-TW'=>'中文-臺灣地区 (incomplete)',
      'ja'=>'日本語 (incomplete)'
    }
  end

  def pagination(path, current_page, pages)
    current_page = current_page.nil? ? 1 : current_page.to_i
    base_url = "#{path}?page="
    content_tag('div',class:'ui pagination menu') do
      if(current_page > 1)
        link_to(base_url + (current_page - 1).to_s , class:'icon item') do
          content_tag('i', nil, class:'left arrow icon')
        end
      else
        link_to('', class:'disabled icon item') do
          content_tag('i', nil, class:'left arrow icon')
        end
      end +
      if(pages < 10)
        (1..pages).to_a.map do |i|
          if i == current_page
            link_to(i, '', class:'active item')
          else
            link_to(i, base_url + i.to_s, class:'item')
          end
        end.reduce(:<<)
      else
        start = (current_page - 4) > 1 ? current_page - 4 : 1
        ending = (current_page + 4) < pages ? pages + 4 : pages
        (start..ending).to_a.map do |i|
          if i == current_page
            link_to(i, '', class:'active item')
          else
            link_to(i, base_url + i.to_s, class:'item')
          end
        end.reduce(:<<)
      end +
      if(current_page < pages)
        link_to(base_url + (current_page + 1).to_s , class:'icon item') do
          content_tag('i', nil, class:'right arrow icon')
        end
      else
        link_to('', class:'disabled icon item') do
          content_tag('i', nil, class:'right arrow icon')
        end
      end
    end
  end
end
