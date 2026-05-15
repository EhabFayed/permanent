class ProductsController < ApplicationController

  def index
    pagy_obj, records = pagy(Product.all.order(:id), page: [params[:page].to_i, 1].max)
    products = records.map do |product|
      {
        id: product.id,
        category: product.category,
        description_ar: product.description_ar,
        description_en: product.description_en,
        is_published: product.is_published,
        size_ar: product.size_ar,
        size_en: product.size_en,
        photos: product.product_photos.map do |photo|
          {
            id: photo.id,
            url: photo.photo.attached? ? url_for(photo.photo) : nil,
            alt_ar: photo.alt_ar,
            alt_en: photo.alt_en,
          }
        end
      }
    end
    render json: { products: products, pagination: pagination_metadata(pagy_obj) }
  end
  def show
    product = Product.find(params[:id])
    data = {
      id: product.id,
      category: product.category,
      description_ar: product.description_ar,
      description_en: product.description_en,
      is_published: product.is_published,
      size_ar: product.size_ar,
      size_en: product.size_en,
      photos: product.product_photos.map do |photo|
        {
          id: photo.id,
          url: photo.photo.attached? ? url_for(photo.photo) : nil,
          alt_ar: photo.alt_ar,
          alt_en: photo.alt_en,
        }
      end
    }
    render json: data
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: {message: 'Product created successfully'}, status: :created
    else
      render json: { error: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      render json: {message: 'Product updated successfully'}, status: :ok
    else
      render json: { error: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    render json: { message: 'Product deleted successfully' }, status: :ok
  end

  private
  def product_params
    params.require(:product).permit(
      :category,
      :description_ar,
      :description_en,
      :size_ar,
      :size_en,
      :is_published,
      product_photos_attributes: [
        :id,
        :alt_ar,
        :alt_en,
        :photo,
        :is_arabic,
        :_destroy
      ]
    )
  end
end
