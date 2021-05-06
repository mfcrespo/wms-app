# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

module ApplicationHelper

  def link_to_fields(name, form, association, **args)
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    fields = form.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + '_fields', builder: builder)
    end
    link_to(name, '#', class: 'add_fields ' + args[:class], data: { id: id, fields: fields.gsub("\n", '') })
  end

end
