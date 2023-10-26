
module CustomHelper
    def custom_div_with_label_and_input_class(group_ID, label_text, input_name, input_class, group_display = '')
      content_tag(:div, class: "form-group #{group_display}", id: group_ID) do
        concat(label_tag(label_text))
        concat(text_field_tag(input_name, nil, class: input_class))
      end
    end

    def custom_property_button(data_target)
        content_tag(:button, "#{data_target.capitalize}", class: "toggle-button", data: {target: data_target})
    end

    def category_form_field(field_name,field_list_name, categories)
        content_tag(:div, class: "form-group mt-2") do
          concat(label_tag(field_name, "Select #{field_name.capitalize}"))
          concat(text_field_tag(field_name, nil, list: field_list_name, class: "form-control"))
          concat(content_tag(:datalist, id: field_list_name) do
            categories.each do |category|
              concat(content_tag(:option, '', label: category["title"].present? ? category["title"] : category, value: category["id"].present? ? category["id"] : category))
            end
          end)
        end
      end
  end
  