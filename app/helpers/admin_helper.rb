# frozen_string_literal: true

module AdminHelper
  def new_link(url, remote: false)
    link_to t('action_labels.new'), url, class: 'btn btn-md btn-success mr-1 pull-right float-right', remote:
  end

  def show_link(url)
    link_to t('action_labels.show'), url, class: 'btn btn-sm btn-info margin-right-5'
  end

  def edit_link(url, text: nil, opts: { css: nil })
    css = opts[:css] || 'btn btn-sm btn-primary mr-1'
    button_text = text || t('action_labels.edit')
    link_to button_text, url, class: css.to_s
  end

  def icon_edit_link(text, url)
    link_to url do
      fa_icon 'pencil-square-o', text:
    end
  end

  def save_link(text: nil)
    button_tag data: { disable_with: '提交中...' }, class: 'btn btn-md btn-success mr-1' do
      text || t('action_labels.submit')
    end
  end

  def destroy_link(url, remote: false, opts: { css: nil })
    css = opts[:css] || 'btn btn-sm btn-danger mr-1'
    link_to t('action_labels.destroy'), url,
            method: :delete, data: { confirm: t('action_labels.are_you_sure') }, class: css.to_s, remote:
  end

  def index_link(url)
    # link_to t("action_labels.back_list"),
    # request.referer.present? ? request.referer : url, class: 'btn btn-md btn-primary mr-1'
    link_to t('action_labels.back_list'), url, class: 'btn btn-md btn-primary mr-1'
  end

  def custom_link(text, url)
    return if url.blank?

    link_to text, url, class: 'btn btn-sm btn-primary mr-1'
  end

  def image_link(url, size: '80x80')
    return if url.blank? || !url.include?('http')

    link_url = url.gsub(/\?.*/, '')
    link_url += '?imageView2/0/h/100/interlace/1|imageslim'
    link_to link_url, target: '_blank' do
      image_tag url, size:, alt: 'image'
    end
  end

  def video_link(url, size: '80x80')
    return if url.blank?

    video_tag rul, size:
  end
end
