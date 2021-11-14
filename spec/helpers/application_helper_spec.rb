describe ApplicationHelper do
  describe "create_select_options" do
    let(:select_input) do
      <<~SELECT
      <select name="contact_file[columns][name]" class="form-select">
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

    it "returns select input with options" do
      expect(create_select_options("name")).to eq select_input
    end
  end
end
