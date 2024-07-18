module ApplicationHelper


  def settings_link(control)
    if control == "users"
      "active-pro active"
     elsif control == "settings/account" 
       "active-pro active"
     elsif control == "users/registrations" 
       "active-pro active"
     elsif control =~ /accounts\/plans/
       "active-pro active"
     else
       "active-pro"
    end
  end

  def field_class(resource, field_name)
    if resource.errors[field_name]
      return "error".html_safe
    else
      return "".html_safe
    end
  end

   def date_created_from_parameters
    if params[:search].present?
      params[:search][:date_created]
    end
  end

  def user_link(title)
    if title =~ /accounts\/users/
      'active'
    elsif title =~ /users\/invitation/
      'active'
    end
  end


  def find_open(controller)
    if controller == 'monitor' || controller == 'users' || controller == 'settings' || controller == 'manage_accounts'
      "active"
    else
      ""
    end
  end

  def find_drop_open(controller)
    if controller == 'monitor' || controller == 'users' || controller == 'settings' || controller == 'manage_accounts'
      "menu-open"
    else
      ""
    end
  end


  def services_link(title)
    if title == "bills"
      'active'
    else
       ""
    end
  end


class MenuTabBuilder < TabsOnRails::Tabs::Builder
  def open_tabs(options = {})
    @context.tag("ul", options, open = true)
  end

  def close_tabs(options = {})
    "</ul>".html_safe
  end

  def tab_for(tab, name, options, item_options = {})
    item_options[:class] = (current_tab?(tab) ? 'nav-item' : 'nav-item')

    @context.content_tag(:li, item_options) do
      @context.link_to(name, options,class: "nav-link #{(current_tab?(tab) ? 'active' : '')}")
    end
  end
end

	def flash_class(level)
	    case level
	        when :notice then "alert alert-info"
	        when :success then "alert alert-success"
	        when :error then "alert alert-error"
	        when :alert then "alert alert-error"
	    end
	end
end
