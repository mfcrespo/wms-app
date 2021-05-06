# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

module ReturnsHelper

  def use_form(item)
    form_with url: returns_path, method: :post do |form|
      concat form.hidden_field(:item_id, value: item.id)
      concat form.submit("Use item", class: "form-inline btn2")
    end
  end

  def return_form(item)
    link_to "Return item", return_path(item), class: "form-inline btn1", method: :delete
  end
end
