module ApplicationHelper
  def create_select_options(attribute_name)
    <<~SELECT
      <select name="contact_file[columns][#{attribute_name}]" class="form-select">
        <option value=""></option>
        <option value="0">One</option>
        <option value="1">Two</option>
        <option value="2">Three</option>
        <option value="3">Four</option>
        <option value="4">Five</option>
        <option value="5">Six</option>
      </select>
    SELECT
  end
end
