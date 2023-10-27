
module CustomHelper
    def custom_div_with_label_and_input_class(group_ID, label_text, input_name, input_class, group_display = '')
      content_tag(:div, class: "form-group #{group_display}", id: group_ID) do
        concat(label_tag(label_text))
        concat(text_field_tag(input_name, nil, class: input_class))
      end
    end

    def custom_property_button(data_target, class_name)
        label_tag = data_target.include?("_") ? data_target.split("_").map(&:capitalize).join(" ") : data_target.capitalize
        content_tag(:button, "#{label_tag}", class: class_name, data: {target: data_target, value: 0})
    end

    def category_form_field(field_name, field_list_name, categories)
        content_tag(:div, class: "form-group mt-2") do
          concat(label_tag(field_name, "Select #{field_name.capitalize}"))
          concat(text_field_tag(field_name, nil, list: field_list_name, class: "form-control"))
          concat(content_tag(:datalist, id: field_list_name, multiple: true) do
            categories.each do |category|
              concat(content_tag(:option, '', label: category["title"].present? ? category["title"] : category, value: category["id"].present? ? category["id"] : category))
            end
          end)
        end
    end

    def multiple_select(field_name, field_list_name, categories)
        content_tag(:div, class: "form-group mt-2") do
          concat(label_tag(field_name, "Select #{field_name.capitalize}"))
          concat(text_field_tag(field_name, nil, list: field_list_name, class: "form-control"))
          concat(select_tag(field_list_name, options_for_select(categories.map { |category| ["#{category['title']}", "#{category['id']}"] }), multiple: true))
        end
    end

    # def multiple_input(group_ID, label_text,field_list_name, input_name, input_class, group_display = '', items)
    #     content_tag(:div, class: "form-group #{group_display}", id: group_ID) do
    #         concat(label_tag(label_text))
    #         concat(text_field_tag(input_name, nil, class: input_class))
    #         concat(content_tag(:div, id: field_list_name) do
    #                 items.map { |item| content_tag(:div, item) }.join.html_safe
    #           end)
    #     end
    # end
    
      



  end
  