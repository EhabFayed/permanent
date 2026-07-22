class WebSiteController < ApplicationController
 skip_before_action :authorize_request

 def blogs_landing
    pagy_obj, records = pagy(Blog.published.order(created_at: :desc), page: [params[:page].to_i, 1].max)
    blogs = records.map do |blog|
      {
        id: blog.id,
        title_ar: blog.title_ar,
        title_en: blog.title_en,
        description_ar: blog.description_ar,
        description_en: blog.description_en,
        category: blog.category,
        slug: blog.slug,
        slug_ar: blog.slug_ar,
        photos: blog.blog_photos.where(is_landing: false).map do |photo|
          {
            id: photo.id,
            url: photo.photo.attached? ? url_for(photo.photo) : nil,
            alt_ar: photo.alt_ar,
            alt_en: photo.alt_en
          }
        end
      }
    end
    render json: { blogs: filter_by_locale(blogs), pagination: pagination_metadata(pagy_obj) }
  end

  def blog_show
    blog = Blog.find_by_any_slug(params[:slug])
    data = {
          id: blog.id,
          title_ar: blog.title_ar,
          title_en: blog.title_en,
          category: blog.category,
          slug: blog.slug,
          slug_ar: blog.slug_ar,
          meta_description_ar: blog.meta_description_ar,
          meta_description_en: blog.meta_description_en,
          meta_title_ar: blog.meta_title_ar,
          meta_title_en: blog.meta_title_en,
          is_published: blog.is_published,
          is_highlighted: blog.is_highlighted,
          landing_photo: blog.blog_photos.where(is_landing: true).map do |photo|
            {
              id: photo.id,
              url: photo.photo.attached? ? url_for(photo.photo) : nil,
              alt_ar: photo.alt_ar,
              alt_en: photo.alt_en,
            }
          end,
          contents: blog.contents.where(is_deleted: false).order(:id).map do |content|
            {
              id: content.id,
              content_ar: content.content_ar,
              content_en: content.content_en,
              is_published: content.is_published,
              photos: content.content_photos.map do |cp|
                {
                  id: cp.id,
                  url: cp.photo.attached? ? url_for(cp.photo) : nil,
                  alt_ar: cp.alt_ar,
                  alt_en: cp.alt_en
                }
              end
            }
          end,
          faqs: blog.faqs.where(is_deleted: false).order(:id).map do |faq|
            {
              id: faq.id,
              question_ar: faq.question_ar,
              question_en: faq.question_en,
              answer_ar: faq.answer_ar,
              answer_en: faq.answer_en,
              is_published: faq.is_published
            }
          end
        }

    render json: filter_by_locale(data)
  end

  def products
    pagy_obj, records = pagy(Product.published.order(created_at: :desc), page: [params[:page].to_i, 1].max)
    products = records.map do |product|
      {
        id: product.id,
        title: product.title,
        title_en: product.title_en,
        description_ar: product.description_ar,
        description_en: product.description_en,
        category: product.category,
        is_published: product.is_published,
        size_ar: product.size_ar,
        size_en: product.size_en,
        photos: product.product_photos.map do |photo|
          {
            id: photo.id,
            url: photo.photo.attached? ? url_for(photo.photo) : nil,
            alt_ar: photo.alt_ar,
            alt_en: photo.alt_en
          }
        end
      }
    end
    render json: { products: filter_by_locale(products), pagination: pagination_metadata(pagy_obj) }
  end

  def faq_about_us
    faqs = Faq.where(is_deleted: false, is_published: true, parentable_id: nil).order(:id)
    faqs_data = faqs.map { |faq|
      {
        id: faq.id,
        question_ar: faq.question_ar,
        question_en: faq.question_en,
        answer_ar: faq.answer_ar,
        answer_en: faq.answer_en
      }
    }
    render json: filter_by_locale(faqs_data)
  end
  private
  def filter_by_locale(data)
      locale = request.headers['locale']
      return data unless %w[ar en].include?(locale)

      if data.is_a?(Hash)
        filtered_hash = {}
        data.each do |key, value|
          key_str = key.to_s
          if key_str.end_with?("_ar", "_en")
            if key_str.end_with?("_#{locale}")
              filtered_hash[key_str.sub("_#{locale}", "").to_sym] = filter_by_locale(value)
            end
          else
            filtered_hash[key] = filter_by_locale(value)
          end
        end
        filtered_hash
      elsif data.is_a?(Array)
        data.map { |item| filter_by_locale(item) }
      else
        data
      end
    end
end