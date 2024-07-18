# frozen_string_literal: true

module LayoutHelper
  def flash_messages(opts = {})
    @layout_flash = opts.fetch(:layout_flash) { true }

    capture do
      flash.each do |name, msg|
        concat content_tag(:div, msg, id: "flash_#{name}", class: "alert #{show_class(name)}")
      end
    end
  end

  def show_class(name)
    if name == "notice"
      'alert-info'
    elsif name == "success"
      'alert-success'
     elsif name == "error"
      'alert-danger'
     else name == "alert"
      'alert-warning'
    end
  end

  def show_layout_flash?
    @layout_flash.nil? ? true : @layout_flash
  end
end

