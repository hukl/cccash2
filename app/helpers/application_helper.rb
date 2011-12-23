# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def error_messages_for(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div class='formErrors #{object.class.name.humanize.downcase}Errors'>\n"
      if message.blank?
        if object.new_record?
          html << "\t\t<h5>There was a problem creating the #{object.class.name.humanize.downcase}</h5>\n"
        else
          html << "\t\t<h5>There was a problem updating the #{object.class.name.humanize.downcase}</h5>\n"
        end
      else
        html << "<h5>#{message}</h5>"
      end
      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
    end
    html.html_safe
  end

  def menu_for_user
    if current_user && current_user.admin?
      render :partial => "shared/admin_menu"
    elsif current_user && !current_user.admin?
      render :partial => "shared/user_menu"
    else
      render :partial => "shared/login_menu"
    end
  end

  def nice_price(price)
    if price.is_a?(Numeric)
      number_to_currency(price ,{:unit => "", :seperator => ","}) + '&euro;'.html_safe
    end
  end

  def show_notice(secs = 3)
    visual_effect(:fade, 'notice',
                  :queue => {:position => 'end', :scope => 'notice' },
                  :delay => secs, :duration => 4) +
    visual_effect(:appear, 'notice',
                  :queue => {:position => 'front', :scope => 'notice' },
                  :duration => 4)
  end

  def flash_js_tag
    if flash[:notice]
      javascript_tag(show_notice)
    end
  end

end
