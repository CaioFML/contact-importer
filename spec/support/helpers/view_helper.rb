module ViewHelper
  private

  def paginate_view(array)
    Kaminari.paginate_array(array).page(1)
  end
end
